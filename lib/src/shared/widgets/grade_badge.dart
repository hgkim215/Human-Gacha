import 'package:flutter/material.dart';
import '../models/human_grade.dart';
import '../../app/theme.dart';

/// 등급 컬러 배지
class GradeBadge extends StatelessWidget {
  const GradeBadge({super.key, required this.grade, this.large = false});

  final HumanGrade grade;
  final bool large;

  Color _color() {
    switch (grade) {
      case HumanGrade.n:
        return GradeColors.n;
      case HumanGrade.r:
        return GradeColors.r;
      case HumanGrade.sr:
        return GradeColors.sr;
      case HumanGrade.ssr:
        return GradeColors.ssr;
      case HumanGrade.ur:
        return GradeColors.ur;
      case HumanGrade.legend:
        return GradeColors.legend;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    final fontSize = large ? 22.0 : 13.0;
    final hPad = large ? 16.0 : 10.0;
    final vPad = large ? 6.0 : 4.0;
    final radius = large ? 10.0 : 6.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        border: Border.all(color: color.withOpacity(0.7), width: 1.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        grade.label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
