import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../draw/draw_animation_screen.dart';

class BadgeRewardScreen extends ConsumerWidget {
  const BadgeRewardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(drawResultProvider);
    final card = result?.card;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildBadgeAnimation(card?.successBadge ?? '생존자'),
              const SizedBox(height: 32),
              Text(
                '🎉 미션 완료!',
                style: GoogleFonts.notoSansKr(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '뱃지가 컬렉션에 추가됩니다',
                style: GoogleFonts.notoSansKr(
                  fontSize: 15,
                  color: const Color(0xFF8080A0),
                ),
              ),
              const SizedBox(height: 24),
              _buildRewardBox(result?.successEgoShards ?? 0),
              const Spacer(),
              _buildActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeAnimation(String badgeName) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (ctx, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Column(
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF66BB6A).withOpacity(0.5),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Text('🏅', style: TextStyle(fontSize: 72)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            badgeName,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF66BB6A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardBox(int shards) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF66BB6A).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _rewardItem('🔮', '자아 파편', '+$shards'),
          _rewardItem('📈', '사람 구실 게이지', '+8%'),
          _rewardItem('🔥', '연속 달성', '+1일'),
        ],
      ),
    );
  }

  Widget _rewardItem(String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.notoSansKr(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF66BB6A),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.notoSansKr(
            fontSize: 11,
            color: const Color(0xFF8080A0),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => context.go('/room'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B61FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              '친구방에 공유하기 →',
              style: GoogleFonts.notoSansKr(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => context.go('/home'),
          child: Text(
            '홈으로 돌아가기',
            style: GoogleFonts.notoSansKr(
              fontSize: 14,
              color: const Color(0xFF6B6B8A),
            ),
          ),
        ),
      ],
    );
  }
}
