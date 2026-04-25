import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/widgets/grade_badge.dart';
import '../../shared/widgets/gacha_button.dart';
import '../demo_mode/demo_state.dart';
import '../demo_mode/demo_seed.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(demoStateProvider);
    final user = demo.user;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildAppBar(context, ref, demo)),
            SliverToBoxAdapter(child: _buildCapsuleSection()),
            SliverToBoxAdapter(child: _buildPickupSection()),
            SliverToBoxAdapter(child: _buildBuffBanner()),
            SliverToBoxAdapter(child: _buildHumanityGauge(user.humanityGauge)),
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildBottomCta(context, user.egoShards),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, WidgetRef ref, DemoConfig demo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '안녕, ${demo.user.nickname} 👋',
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  color: const Color(0xFF8080A0),
                ),
              ),
              Text(
                '오늘의 인간을 뽑을 시간',
                style: GoogleFonts.notoSansKr(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          // 데모 모드 뱃지
          if (demo.isDemoMode)
            GestureDetector(
              onTap: () => _showDemoMenu(context, ref),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A45),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF7B61FF), width: 1),
                ),
                child: Text(
                  'DEMO',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF9D8BFF),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF9D8BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                demo.user.nickname.isNotEmpty ? demo.user.nickname[0] : '나',
                style: GoogleFonts.notoSansKr(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  void _showDemoMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _DemoMenu(ref: ref),
    );
  }

  Widget _buildCapsuleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A3E), Color(0xFF0D1B3E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF7B61FF).withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            const _PulsingCapsule(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘의 자아 캡슐 도착 ✨',
                    style: GoogleFonts.notoSansKr(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '지금 뽑지 않으면 내일은 또 달라집니다',
                    style: GoogleFonts.notoSansKr(
                      fontSize: 12,
                      color: const Color(0xFF8080A0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickupSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            icon: '⭐',
            title: '오늘의 픽업 인간',
            subtitle: '이 등급이 오늘 더 잘 나옵니다',
          ),
          const SizedBox(height: 12),
          ...DemoSeed.pickupHumans.map(
            (p) => _PickupCard(grade: p.grade, title: p.title),
          ),
        ],
      ),
    );
  }

  Widget _buildBuffBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(icon: '🎲', title: '현재 적용 중인 버프'),
          const SizedBox(height: 10),
          ...DemoSeed.buffs.map(
            (b) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF66BB6A).withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Text('✅', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 10),
                  Text(
                    b,
                    style: GoogleFonts.notoSansKr(
                      fontSize: 13,
                      color: const Color(0xFF88D8A0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHumanityGauge(int value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '사람 구실 게이지',
                style: GoogleFonts.notoSansKr(
                  fontSize: 13,
                  color: const Color(0xFF8080A0),
                ),
              ),
              const Spacer(),
              Text(
                '$value%',
                style: GoogleFonts.notoSansKr(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9D8BFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: const Color(0xFF2A2A45),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF7B61FF),
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context, int egoShards) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🔮', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                '자아 파편 $egoShards개 보유 중',
                style: GoogleFonts.notoSansKr(
                  fontSize: 13,
                  color: const Color(0xFF8080A0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GachaButton(onTap: () => context.push('/mood')),
        ],
      ),
    );
  }
}

// ─── 보조 위젯 ───────────────────────────────────────

class _PulsingCapsule extends StatefulWidget {
  const _PulsingCapsule();

  @override
  State<_PulsingCapsule> createState() => _PulsingCapsuleState();
}

class _PulsingCapsuleState extends State<_PulsingCapsule>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _scale = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [Color(0xFF9D8BFF), Color(0xFF6B48FF)],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B61FF).withOpacity(0.6),
              blurRadius: 16,
            ),
          ],
        ),
        child: const Center(child: Text('🎱', style: TextStyle(fontSize: 26))),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final String icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.notoSansKr(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(width: 8),
          Text(
            subtitle!,
            style: GoogleFonts.notoSansKr(
              fontSize: 12,
              color: const Color(0xFF6B6B8A),
            ),
          ),
        ],
      ],
    );
  }
}

class _PickupCard extends StatelessWidget {
  const _PickupCard({required this.grade, required this.title});

  final HumanGrade grade;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A45), width: 1),
      ),
      child: Row(
        children: [
          GradeBadge(grade: grade),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.notoSansKr(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const Text('✨', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class _DemoMenu extends ConsumerWidget {
  const _DemoMenu({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demo = ref.watch(demoStateProvider);
    final notifier = ref.read(demoStateProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎮 데모 모드 설정',
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '시나리오 선택',
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF8080A0),
            ),
          ),
          const SizedBox(height: 8),
          _scenarioBtn('⭐ SR 기본 시나리오', () {
            notifier.applySrScenario();
            Navigator.pop(context);
          }),
          _scenarioBtn('💜 SSR 임팩트 시나리오', () {
            notifier.applySsrScenario();
            Navigator.pop(context);
          }),
          _scenarioBtn('💀 실패 보상 시나리오', () {
            notifier.applyFailureScenario();
            Navigator.pop(context);
          }),
          const SizedBox(height: 12),
          Text(
            '현재: ${demo.forcedGrade.label} / ${demo.forcedOutcome}',
            style: GoogleFonts.notoSansKr(
              fontSize: 12,
              color: const Color(0xFF6B6B8A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2A2A45)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.notoSansKr(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
