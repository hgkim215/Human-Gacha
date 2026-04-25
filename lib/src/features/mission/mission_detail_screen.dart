import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/draw_result.dart';
import '../../shared/widgets/grade_badge.dart';
import '../draw/draw_animation_screen.dart';

class MissionDetailScreen extends ConsumerWidget {
  const MissionDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(drawResultProvider);
    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final card = result.card;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    GradeBadge(grade: card.grade, large: true),
                    const SizedBox(height: 12),
                    Text(
                      card.gradeTitle,
                      style: GoogleFonts.notoSansKr(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildMissionCard(card.mission),
                    const SizedBox(height: 20),
                    _buildRewardPreview(card),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildActions(context, ref, result),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: Colors.white,
            onPressed: () => context.pop(),
          ),
          Text(
            '오늘의 미션',
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(String mission) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A3E), Color(0xFF0D1B3E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF7B61FF).withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎯', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(
                '오늘의 미션',
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9D8BFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            mission,
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardPreview(dynamic card) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D2818),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF66BB6A).withOpacity(0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🏅', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 6),
                Text(
                  '성공하면',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 11,
                    color: const Color(0xFF66BB6A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  card.successBadge,
                  style: GoogleFonts.notoSansKr(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '뱃지 획득',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 11,
                    color: const Color(0xFF66BB6A),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A1000),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFFF7043).withOpacity(0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💀', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 6),
                Text(
                  '실패하면',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 11,
                    color: const Color(0xFFFF7043),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  card.failureTitle,
                  style: GoogleFonts.notoSansKr(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '칭호 획득',
                  style: GoogleFonts.notoSansKr(
                    fontSize: 11,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, DrawResult result) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                final updated = result.copyWith(status: DrawStatus.success);
                ref.read(drawResultProvider.notifier).state = updated;
                context.pushReplacement('/reward/success');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                '✅ 미션 완료!',
                style: GoogleFonts.notoSansKr(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                final updated = result.copyWith(status: DrawStatus.failure);
                ref.read(drawResultProvider.notifier).state = updated;
                context.pushReplacement('/reward/failure');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF5A2A1A)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                '😭 오늘은 실패...',
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  color: const Color(0xFFFF7043),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
