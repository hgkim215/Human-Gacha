import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/widgets/grade_badge.dart';
import 'dummy_feed_data.dart';

class WholeRoomSummary extends StatelessWidget {
  const WholeRoomSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = DummyFeedData.wholeRoomStats;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          _buildDemoNotice(),
          const SizedBox(height: 16),
          _buildStatCard(stats),
          const SizedBox(height: 16),
          _buildHighlights(),
        ],
      ),
    );
  }

  Widget _buildDemoNotice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '데모 데이터입니다. 운영 시 실제 통계로 교체됩니다.',
              style: GoogleFonts.notoSansKr(
                fontSize: 11,
                color: const Color(0xFFB0A060),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    ({
      int nPercent,
      String mostFailedMission,
      int totalUsers,
      int legendCount,
      int srOrAbovePercent,
    })
    stats,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF0D0D20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2A2A45)),
      ),
      child: Column(
        children: [
          Text(
            '오늘의 인간 가챠 현황',
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _StatItem(
                value: '${stats.totalUsers}명',
                label: '오늘 뽑기 완료',
                emoji: '🎲',
              ),
              _StatItem(
                value: '${stats.nPercent}%',
                label: 'N급 비율',
                emoji: '💀',
              ),
              _StatItem(
                value: '${stats.srOrAbovePercent}%',
                label: 'SR 이상',
                emoji: '⭐',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Text('🏆', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '오늘 가장 많이 실패한 미션',
                        style: GoogleFonts.notoSansKr(
                          fontSize: 11,
                          color: const Color(0xFF6B6B8A),
                        ),
                      ),
                      Text(
                        stats.mostFailedMission,
                        style: GoogleFonts.notoSansKr(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '오늘 전체 유저의 ${stats.nPercent}%가 N급입니다.\n사회는 아직 굴러갑니다. 😅',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF8080A0),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 하이라이트',
          style: GoogleFonts.notoSansKr(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...DummyFeedData.wholeRoomPosts.map(
          (p) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: p.grade == HumanGrade.legend
                    ? const Color(0xFFFFD700).withOpacity(0.5)
                    : const Color(0xFF2A2A45),
              ),
            ),
            child: Row(
              children: [
                GradeBadge(grade: p.grade),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.title,
                        style: GoogleFonts.notoSansKr(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (p.badge.isNotEmpty)
                        Text(
                          '🏅 ${p.badge}',
                          style: GoogleFonts.notoSansKr(
                            fontSize: 12,
                            color: const Color(0xFF66BB6A),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.emoji,
  });

  final String value;
  final String label;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.notoSansKr(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 11,
              color: const Color(0xFF6B6B8A),
            ),
          ),
        ],
      ),
    );
  }
}
