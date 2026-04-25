import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/services/ai_card_service.dart';
import '../../shared/models/draw_result.dart';
import '../demo_mode/demo_state.dart';
import 'mood_select_screen.dart';

/// 뽑기 결과 Provider (전역으로 result 화면과 공유)
final drawResultProvider = StateProvider<DrawResult?>((ref) => null);

class DrawAnimationScreen extends ConsumerStatefulWidget {
  const DrawAnimationScreen({super.key});

  @override
  ConsumerState<DrawAnimationScreen> createState() =>
      _DrawAnimationScreenState();
}

class _DrawAnimationScreenState extends ConsumerState<DrawAnimationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _shakeCtrl;
  late final AnimationController _fadeCtrl;
  late final AnimationController _revealCtrl;

  int _phase = 0; // 0=스캔중 1=실루엣 2=등급공개 3=완료
  final List<String> _scanTexts = [
    '인간성 스캔 중...',
    '어제의 양심 잔여량 확인 중...',
    '사회적 생존 가능성 계산 중...',
    '침대와의 협상 기록 분석 중...',
    '오늘의 인간 타입 확정!',
  ];
  int _scanIndex = 0;
  HumanGrade? _grade;
  bool _cardReady = false;

  @override
  void initState() {
    super.initState();

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _revealCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _startSequence());
  }

  Future<void> _startSequence() async {
    // Phase 0: 스캔 텍스트 순환
    _fadeCtrl.forward();
    for (int i = 0; i < _scanTexts.length; i++) {
      if (!mounted) return;
      setState(() => _scanIndex = i);
      await Future<void>.delayed(const Duration(milliseconds: 700));
    }

    // Phase 1: 등급 결정 + 실루엣
    final demo = ref.read(demoStateProvider);
    final mood = ref.read(moodSelectProvider);

    final grade = drawGrade(
      streak: demo.user.streak,
      completedYesterday: demo.user.streak > 0,
      cheerReactionCount: 3,
      forcedGrade: demo.isDemoMode ? demo.forcedGrade : null,
    );

    if (!mounted) return;
    setState(() {
      _grade = grade;
      _phase = 1;
    });
    await Future<void>.delayed(const Duration(milliseconds: 900));

    // Phase 2: 등급 공개
    if (!mounted) return;
    setState(() => _phase = 2);
    _revealCtrl.forward();
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Phase 3: AI 카드 생성 (백그라운드)
    final aiService = AiCardService(aiMode: demo.aiMode);
    final effectiveMood = mood.isEmpty ? ['잠 부족', '카페인 필요', '코테 준비 중'] : mood;

    final card = await aiService.generateCard(
      profile: demo.user,
      todayMood: effectiveMood,
      grade: grade,
    );

    if (!mounted) return;

    // Demo 시드 기반이더라도 AI가 돌아오면 우선 사용
    final result = DrawResult(card: card, todayMood: effectiveMood);
    ref.read(drawResultProvider.notifier).state = result;

    setState(() {
      _phase = 3;
      _cardReady = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) context.pushReplacement('/result');
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _fadeCtrl.dispose();
    _revealCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_phase < 2) _buildScanPhase(),
                if (_phase == 1) _buildSilhouette(),
                if (_phase >= 2 && _grade != null) _buildReveal(),
                if (_phase == 3) _buildLoading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanPhase() {
    return Column(
      children: [
        const _SpinningCapsule(),
        const SizedBox(height: 40),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _scanTexts[_scanIndex],
            key: ValueKey(_scanIndex),
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF9D8BFF),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildDots(),
      ],
    );
  }

  Widget _buildSilhouette() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A45),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            '???',
            style: GoogleFonts.notoSansKr(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4A4A70),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReveal() {
    final grade = _grade!;
    final color = _gradeColor(grade);

    return ScaleTransition(
      scale: CurvedAnimation(parent: _revealCtrl, curve: Curves.elasticOut),
      child: Column(
        children: [
          Text('🎉', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              border: Border.all(color: color, width: 2.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Text(
              grade.label,
              style: GoogleFonts.notoSansKr(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '등급 확정!',
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              color: const Color(0xFF9D8BFF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Text(
        _cardReady ? '카드 로딩 완료' : 'AI 카드 생성 중...',
        style: GoogleFonts.notoSansKr(
          fontSize: 13,
          color: const Color(0xFF6B6B8A),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return _AnimatedDot(delay: Duration(milliseconds: i * 200));
      }),
    );
  }

  Color _gradeColor(HumanGrade g) {
    switch (g) {
      case HumanGrade.n:
        return const Color(0xFF9E9E9E);
      case HumanGrade.r:
        return const Color(0xFF66BB6A);
      case HumanGrade.sr:
        return const Color(0xFF42A5F5);
      case HumanGrade.ssr:
        return const Color(0xFFAB47BC);
      case HumanGrade.ur:
        return const Color(0xFFFF7043);
      case HumanGrade.legend:
        return const Color(0xFFFFD700);
    }
  }
}

class _SpinningCapsule extends StatefulWidget {
  const _SpinningCapsule();

  @override
  State<_SpinningCapsule> createState() => _SpinningCapsuleState();
}

class _SpinningCapsuleState extends State<_SpinningCapsule>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _c,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: const SweepGradient(
            colors: [
              Color(0xFF7B61FF),
              Color(0xFF9D8BFF),
              Color(0xFF4A3ABF),
              Color(0xFF7B61FF),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B61FF).withOpacity(0.6),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Center(child: Text('🎱', style: TextStyle(fontSize: 42))),
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  const _AnimatedDot({required this.delay});

  final Duration delay;

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween<double>(begin: 0.2, end: 1.0).animate(_c);
    Future<void>.delayed(widget.delay, () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          color: Color(0xFF7B61FF),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
