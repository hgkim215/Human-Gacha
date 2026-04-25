import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// 오늘 상태 선택 상태
final moodSelectProvider =
    StateNotifierProvider<MoodSelectNotifier, List<String>>(
      (ref) => MoodSelectNotifier(),
    );

class MoodSelectNotifier extends StateNotifier<List<String>> {
  MoodSelectNotifier() : super([]);

  void toggle(String item) {
    final current = List<String>.from(state);
    if (current.contains(item)) {
      current.remove(item);
    } else if (current.length < 3) {
      current.add(item);
    }
    state = current;
  }

  void clear() => state = [];
}

// ─── 화면 ─────────────────────────────────────────────

class MoodSelectScreen extends ConsumerWidget {
  const MoodSelectScreen({super.key});

  static const _options = [
    '잠 부족',
    '카페인 필요',
    '멘탈 나감',
    '기분 좋음',
    '돈 없음',
    '운동 미룸',
    '코테 준비 중',
    '답장 미룸',
    '방 더러움',
    '오늘은 좀 가능',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(moodSelectProvider);
    final notifier = ref.read(moodSelectProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘 상태를 알려줘',
                      style: GoogleFonts.notoSansKr(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '최대 3개까지. AI가 맞춤 미션을 뽑아줍니다',
                      style: GoogleFonts.notoSansKr(
                        fontSize: 14,
                        color: const Color(0xFF8080A0),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _options.map((opt) {
                        final isSelected = selected.contains(opt);
                        final isDisabled = !isSelected && selected.length >= 3;
                        return _MoodChip(
                          label: opt,
                          selected: isSelected,
                          disabled: isDisabled,
                          onTap: () => notifier.toggle(opt),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    if (selected.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A2E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF7B61FF).withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text('🎯', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '선택됨: ${selected.join(', ')}',
                                style: GoogleFonts.notoSansKr(
                                  fontSize: 13,
                                  color: const Color(0xFF9D8BFF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            _buildBottomCta(context, selected),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            '오늘 상태 선택',
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

  Widget _buildBottomCta(BuildContext context, List<String> selected) {
    final canProceed = selected.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: canProceed ? () => context.push('/draw') : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canProceed
                    ? const Color(0xFF7B61FF)
                    : const Color(0xFF2A2A45),
                disabledBackgroundColor: const Color(0xFF2A2A45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                canProceed ? '인간 가챠 뽑기 →' : '상태를 선택해주세요',
                style: GoogleFonts.notoSansKr(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: canProceed ? Colors.white : const Color(0xFF6B6B8A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.label,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF7B61FF).withOpacity(0.25)
              : disabled
              ? const Color(0xFF141420)
              : const Color(0xFF1A1A2E),
          border: Border.all(
            color: selected
                ? const Color(0xFF7B61FF)
                : disabled
                ? const Color(0xFF1A1A30)
                : const Color(0xFF2A2A45),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: GoogleFonts.notoSansKr(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected
                ? const Color(0xFF9D8BFF)
                : disabled
                ? const Color(0xFF3A3A5C)
                : const Color(0xFFB0B0C8),
          ),
        ),
      ),
    );
  }
}
