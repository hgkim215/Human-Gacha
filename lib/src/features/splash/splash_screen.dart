import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../demo_mode/demo_state.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildLogo(),
              const SizedBox(height: 24),
              _buildTagline(),
              const Spacer(flex: 3),
              _buildActions(context, ref),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: [Color(0xFF9D8BFF), Color(0xFF4A3ABF)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B61FF).withOpacity(0.5),
                blurRadius: 40,
                spreadRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text('🎱', style: TextStyle(fontSize: 48)),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '인간 가챠',
          style: GoogleFonts.notoSansKr(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        Text(
          '갓생을 강요하지 않는다.',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSansKr(
            fontSize: 16,
            color: const Color(0xFF9D8BFF),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '오늘 하루 덜 망한 인간을 뽑는다.',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSansKr(
            fontSize: 16,
            color: const Color(0xFF9D8BFF),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2A2A45), width: 1),
          ),
          child: Column(
            children: [
              _featureRow('🎲', '오늘 상태를 고르면 AI가 인간 등급을 뽑아줍니다'),
              const SizedBox(height: 8),
              _featureRow('⭐', '미션을 성공해야 뱃지가 확정됩니다'),
              const SizedBox(height: 8),
              _featureRow('💀', '실패해도 칭호와 자아 파편이 남습니다'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _featureRow(String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFFB0B0C8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              // 데모 모드로 바로 홈 진입
              ref.read(demoStateProvider.notifier).setDemoMode(true);
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B61FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              '🎮 데모로 시작하기',
              style: GoogleFonts.notoSansKr(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () {
              ref.read(demoStateProvider.notifier).setDemoMode(false);
              context.go('/onboarding');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF3A3A5C), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              '처음부터 온보딩 하기',
              style: GoogleFonts.notoSansKr(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9D8BFF),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
