import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/models/room_post.dart';
import '../../shared/widgets/grade_badge.dart';

/// 친구방 피드 타일 반응 상태
final reactionProvider =
    StateNotifierProvider.family<ReactionNotifier, Map<String, int>, String>(
      (ref, postId) => ReactionNotifier({}),
    );

class ReactionNotifier extends StateNotifier<Map<String, int>> {
  ReactionNotifier(super.state);

  void increment(String key) {
    state = Map<String, int>.from(state)..[key] = (state[key] ?? 0) + 1;
  }
}

// ─── 친구방 피드 타일 ──────────────────────────────

class FriendFeedTile extends ConsumerWidget {
  const FriendFeedTile({super.key, required this.post});

  final RoomPost post;

  static const _reactionLabels = [
    '인정',
    '구라 ㄴ',
    '인간 승리',
    '내 얘기임',
    '지켜본다',
    '실패 예약',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extra = ref.watch(reactionProvider(post.id));
    final notifier = ref.read(reactionProvider(post.id).notifier);

    final isHighGrade = post.grade.isHighGrade;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: post.isMe
              ? const Color(0xFF7B61FF).withOpacity(0.6)
              : isHighGrade
              ? _gradeColor(post.grade).withOpacity(0.4)
              : const Color(0xFF2A2A45),
          width: post.isMe || isHighGrade ? 1.5 : 1,
        ),
        boxShadow: isHighGrade
            ? [
                BoxShadow(
                  color: _gradeColor(post.grade).withOpacity(0.15),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더: 닉네임 + 등급
            Row(
              children: [
                _Avatar(nickname: post.nickname, isMe: post.isMe),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.isMe ? '${post.nickname} (나)' : post.nickname,
                            style: GoogleFonts.notoSansKr(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (post.isMe) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B61FF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '방금',
                                style: GoogleFonts.notoSansKr(
                                  fontSize: 10,
                                  color: const Color(0xFF9D8BFF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      GradeBadge(grade: post.grade),
                    ],
                  ),
                ),
                _StatusChip(status: post.status),
              ],
            ),
            const SizedBox(height: 12),

            // 등급 타이틀
            Text(
              post.gradeTitle,
              style: GoogleFonts.notoSansKr(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            // 성공 뱃지 / 실패 칭호
            if (post.badgeTitle != null) ...[
              const SizedBox(height: 4),
              Text(
                '🏅 ${post.badgeTitle}',
                style: GoogleFonts.notoSansKr(
                  fontSize: 13,
                  color: const Color(0xFF66BB6A),
                ),
              ),
            ],
            if (post.failureTitle != null && post.status == 'failure') ...[
              const SizedBox(height: 4),
              Text(
                '💀 ${post.failureTitle}',
                style: GoogleFonts.notoSansKr(
                  fontSize: 13,
                  color: const Color(0xFFFF7043),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // 리액션 버튼
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _reactionLabels.map((label) {
                final base = post.reactions[label] ?? 0;
                final mine = extra[label] ?? 0;
                final total = base + mine;
                return _ReactionButton(
                  label: label,
                  count: total,
                  onTap: () => notifier.increment(label),
                );
              }).toList(),
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
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.nickname, this.isMe = false});

  final String nickname;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: isMe
            ? const LinearGradient(
                colors: [Color(0xFF7B61FF), Color(0xFF9D8BFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF2A2A45), Color(0xFF3A3A60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          nickname.isNotEmpty ? nickname[0] : '?',
          style: GoogleFonts.notoSansKr(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'success' => ('성공', const Color(0xFF66BB6A)),
      'failure' => ('실패', const Color(0xFFFF7043)),
      _ => ('도전 중', const Color(0xFF9D8BFF)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.notoSansKr(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _ReactionButton extends StatefulWidget {
  const _ReactionButton({
    required this.label,
    required this.count,
    required this.onTap,
  });

  final String label;
  final int count;
  final VoidCallback onTap;

  @override
  State<_ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<_ReactionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _pressed = true);
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _pressed
              ? const Color(0xFF7B61FF).withOpacity(0.2)
              : const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _pressed
                ? const Color(0xFF7B61FF).withOpacity(0.6)
                : const Color(0xFF2A2A45),
          ),
        ),
        child: Text(
          widget.count > 0 ? '${widget.label} ${widget.count}' : widget.label,
          style: GoogleFonts.notoSansKr(
            fontSize: 12,
            color: _pressed ? const Color(0xFF9D8BFF) : const Color(0xFF8080A0),
            fontWeight: _pressed ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
