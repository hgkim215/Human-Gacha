import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../draw/draw_animation_screen.dart';

class FailureRewardScreen extends ConsumerWidget {
  const FailureRewardScreen({super.key});

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
              _buildFailureAnimation(card?.failureTitle ?? '오늘은 여기까지'),
              const SizedBox(height: 24),
              _buildFailureMessage(card?.failureMessage ?? '오늘은 여기까지였습니다.'),
              const SizedBox(height: 24),
              _buildShardReward(result?.failureEgoShards ?? 1),
              const Spacer(),
              _buildActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFailureAnimation(String failureTitle) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutBack,
      builder: (ctx, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF2A1000),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFF7043).withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF7043).withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Center(
              child: Text('💀', style: TextStyle(fontSize: 56)),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF7043).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFF7043).withOpacity(0.5),
              ),
            ),
            child: Text(
              failureTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansKr(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFF7043),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '칭호 획득',
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF8080A0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A45)),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 15,
              color: const Color(0xFFB0B0C8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '실패도 기록입니다. 내일 다시 뽑아요 💪',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF6B6B8A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShardReward(int shards) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A45)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔮', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(
            '자아 파편 +$shards 획득',
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF9D8BFF),
            ),
          ),
        ],
      ),
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
              '친구방에서 구경하기 →',
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
