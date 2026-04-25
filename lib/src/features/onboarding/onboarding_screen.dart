import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_state.dart';
import '../demo_mode/demo_state.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  final _personas = [
    '취준 인간',
    '코테 인간',
    '출근 인간',
    '대학생 인간',
    '운동 미룸 인간',
    '갓생 희망 인간',
    '그냥 생존 인간',
  ];

  final _struggles = [
    '아침 기상',
    '운동',
    '공부/코테',
    '이력서/포폴',
    '방 정리',
    '돈 아끼기',
    '답장하기',
    '일찍 자기',
  ];

  final _difficulties = ['숨 쉬듯 가볍게', '조금 인간답게', '오늘은 갓생 맛보기'];
  final _tones = ['순한맛', '적당히 킹받게', '친구방 공개 처형맛'];

  void _next() {
    if (_page < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
      setState(() => _page++);
    } else {
      _finish();
    }
  }

  void _finish() {
    final answers = ref.read(onboardingProvider);
    final profile = answers.toUserProfile();
    ref.read(demoStateProvider.notifier).updateUser(profile);
    context.go('/home');
  }

  void _skip() {
    // 건너뛰기: 기본값 유지
    context.go('/home');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final answers = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgress(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildQ1(answers, notifier),
                  _buildQ2(answers, notifier),
                  _buildQ3(answers, notifier),
                  _buildQ4(answers, notifier),
                ],
              ),
            ),
            _buildBottomActions(answers),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        children: [
          Text(
            '인간 가챠',
            style: GoogleFonts.notoSansKr(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF9D8BFF),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _skip,
            child: Text(
              '건너뛰기',
              style: GoogleFonts.notoSansKr(
                fontSize: 13,
                color: const Color(0xFF6B6B8A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(4, (i) {
          return Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i <= _page
                    ? const Color(0xFF7B61FF)
                    : const Color(0xFF2A2A45),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQ1(OnboardingAnswers answers, OnboardingNotifier notifier) {
    return _buildQuestion(
      emoji: '🧬',
      question: '요즘 나는 어떤 인간인가요?',
      subtext: '가장 가까운 것 하나를 골라주세요',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _personas.map((p) {
          final selected = answers.persona == p;
          return _ChoiceChip(
            label: p,
            selected: selected,
            onTap: () => notifier.setPersona(p),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQ2(OnboardingAnswers answers, OnboardingNotifier notifier) {
    return _buildQuestion(
      emoji: '💀',
      question: '요즘 제일 자주 실패하는 건?',
      subtext: '최대 3개까지 고를 수 있어요',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _struggles.map((s) {
          final selected = answers.mainStruggles.contains(s);
          return _ChoiceChip(
            label: s,
            selected: selected,
            onTap: () => notifier.toggleStruggle(s),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQ3(OnboardingAnswers answers, OnboardingNotifier notifier) {
    return _buildQuestion(
      emoji: '⚡',
      question: '미션 난이도는?',
      subtext: '부담 없는 걸 골라도 됩니다',
      child: Column(
        children: _difficulties.map((d) {
          final selected = answers.difficulty == d;
          return _RadioTile(
            label: d,
            selected: selected,
            onTap: () => notifier.setDifficulty(d),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQ4(OnboardingAnswers answers, OnboardingNotifier notifier) {
    return _buildQuestion(
      emoji: '🔥',
      question: '말투 강도는?',
      subtext: '카드 문구 느낌이 달라져요',
      child: Column(
        children: _tones.map((t) {
          final selected = answers.tone == t;
          return _RadioTile(
            label: t,
            selected: selected,
            onTap: () => notifier.setTone(t),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuestion({
    required String emoji,
    required String question,
    required String subtext,
    required Widget child,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            question,
            style: GoogleFonts.notoSansKr(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF8080A0),
            ),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildBottomActions(OnboardingAnswers answers) {
    final canNext = _pageCanProceed(answers);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: canNext ? _next : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canNext
                ? const Color(0xFF7B61FF)
                : const Color(0xFF2A2A45),
            disabledBackgroundColor: const Color(0xFF2A2A45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            _page < 3 ? '다음' : '뽑기 시작하기',
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: canNext ? Colors.white : const Color(0xFF6B6B8A),
            ),
          ),
        ),
      ),
    );
  }

  bool _pageCanProceed(OnboardingAnswers answers) {
    switch (_page) {
      case 0:
        return answers.persona.isNotEmpty;
      case 1:
        return answers.mainStruggles.isNotEmpty;
      case 2:
        return answers.difficulty.isNotEmpty;
      case 3:
        return answers.tone.isNotEmpty;
      default:
        return false;
    }
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF7B61FF).withOpacity(0.25)
              : const Color(0xFF1A1A2E),
          border: Border.all(
            color: selected ? const Color(0xFF7B61FF) : const Color(0xFF3A3A5C),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.notoSansKr(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected ? const Color(0xFF9D8BFF) : const Color(0xFFB0B0C8),
          ),
        ),
      ),
    );
  }
}

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF7B61FF).withOpacity(0.2)
              : const Color(0xFF1A1A2E),
          border: Border.all(
            color: selected ? const Color(0xFF7B61FF) : const Color(0xFF2A2A45),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.notoSansKr(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  color: selected ? Colors.white : const Color(0xFFB0B0C8),
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF7B61FF),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
