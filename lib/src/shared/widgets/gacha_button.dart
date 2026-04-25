import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 인간 가챠 뽑기 메인 CTA 버튼
class GachaButton extends StatefulWidget {
  const GachaButton({
    super.key,
    required this.onTap,
    this.label = '인간 가챠 뽑기',
    this.enabled = true,
  });

  final VoidCallback onTap;
  final String label;
  final bool enabled;

  @override
  State<GachaButton> createState() => _GachaButtonState();
}

class _GachaButtonState extends State<GachaButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0,
      upperBound: 0.04,
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    if (widget.enabled) widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? _onTapDown : null,
      onTapUp: widget.enabled ? _onTapUp : null,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: widget.enabled
                ? const LinearGradient(
                    colors: [Color(0xFF6B48FF), Color(0xFF9D8BFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFF3A3A5C), Color(0xFF3A3A5C)],
                  ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.enabled
                ? [
                    BoxShadow(
                      color: const Color(0xFF7B61FF).withOpacity(0.45),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.notoSansKr(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: widget.enabled ? Colors.white : const Color(0xFF6B6B8A),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
