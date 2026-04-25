import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/draw_result.dart';
import '../draw/draw_animation_screen.dart';
import 'human_card_widget.dart';

class DrawResultScreen extends ConsumerWidget {
  const DrawResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(drawResultProvider);

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Column(
                  children: [
                    HumanCardWidget(card: result.card),
                    const SizedBox(height: 16),
                    _buildShareHint(result),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            _buildBottomActions(context, result),
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
            icon: const Icon(Icons.home_outlined, size: 22),
            color: const Color(0xFF8080A0),
            onPressed: () => context.go('/home'),
          ),
          const Spacer(),
          Text(
            '인간 카드 확정',
            style: GoogleFonts.notoSansKr(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildShareHint(DrawResult result) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text('📢', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              result.card.shareText,
              style: GoogleFonts.notoSansKr(
                fontSize: 12,
                color: const Color(0xFF8080A0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, DrawResult result) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        children: [
          Text(
            '미션을 수행하고 뱃지를 확정하세요!',
            style: GoogleFonts.notoSansKr(
              fontSize: 13,
              color: const Color(0xFF8080A0),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => context.push('/mission'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B61FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                '미션 확인하기 →',
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
            height: 46,
            child: OutlinedButton(
              onPressed: () => context.go('/room'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF3A3A5C)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                '친구방에서 구경하기',
                style: GoogleFonts.notoSansKr(
                  fontSize: 14,
                  color: const Color(0xFF9D8BFF),
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
