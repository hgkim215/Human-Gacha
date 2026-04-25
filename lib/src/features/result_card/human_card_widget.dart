import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/human_card.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/widgets/grade_badge.dart';

/// Screenshotable 인간 카드 위젯
class HumanCardWidget extends StatelessWidget {
  const HumanCardWidget({super.key, required this.card});

  final HumanCard card;

  @override
  Widget build(BuildContext context) {
    final color = _gradeColor(card.grade);
    final gradient = _gradeGradient(card.grade);

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 등급 배지 + 후보 뱃지
            Row(
              children: [
                GradeBadge(grade: card.grade, large: true),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '후보',
                    style: GoogleFonts.notoSansKr(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                ),
                if (card.isFallback) ...[
                  const Spacer(),
                  Icon(Icons.bolt, color: color.withOpacity(0.7), size: 16),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // 등급 타이틀
            Text(
              card.gradeTitle,
              style: GoogleFonts.notoSansKr(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // 설명
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                card.description,
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.85),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 미션
            _InfoRow(
              icon: '🎯',
              label: '오늘의 미션',
              value: card.mission,
              color: color,
            ),
            const SizedBox(height: 10),

            // 성공/실패 분기
            Row(
              children: [
                Expanded(
                  child: _SmallInfoCard(
                    emoji: '🏅',
                    label: '성공 뱃지',
                    value: card.successBadge,
                    color: const Color(0xFF66BB6A),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SmallInfoCard(
                    emoji: '💀',
                    label: '실패 칭호',
                    value: card.failureTitle,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

  LinearGradient _gradeGradient(HumanGrade g) {
    switch (g) {
      case HumanGrade.n:
        return const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF2A2A3E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case HumanGrade.r:
        return const LinearGradient(
          colors: [Color(0xFF0D2818), Color(0xFF1A4020)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case HumanGrade.sr:
        return const LinearGradient(
          colors: [Color(0xFF0D1B3E), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case HumanGrade.ssr:
        return const LinearGradient(
          colors: [Color(0xFF1A0828), Color(0xFF6A1B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case HumanGrade.ur:
        return const LinearGradient(
          colors: [Color(0xFF2A1000), Color(0xFFBF360C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case HumanGrade.legend:
        return const LinearGradient(
          colors: [Color(0xFF2A1F00), Color(0xFFFF8F00), Color(0xFFFFD700)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final String icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.notoSansKr(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.notoSansKr(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallInfoCard extends StatelessWidget {
  const _SmallInfoCard({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  final String emoji;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.notoSansKr(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.notoSansKr(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
