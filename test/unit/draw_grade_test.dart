import 'package:flutter_test/flutter_test.dart';
import 'package:human_gacha/src/shared/models/human_grade.dart';

void main() {
  group('drawGrade()', () {
    test('forcedGrade가 있으면 항상 해당 등급 반환', () {
      final result = drawGrade(
        streak: 0,
        completedYesterday: false,
        cheerReactionCount: 0,
        forcedGrade: HumanGrade.ssr,
      );
      expect(result, HumanGrade.ssr);
    });

    test('forcedGrade가 없으면 HumanGrade 범위 내 반환', () {
      for (int i = 0; i < 50; i++) {
        final result = drawGrade(
          streak: 0,
          completedYesterday: false,
          cheerReactionCount: 0,
        );
        expect(HumanGrade.values.contains(result), isTrue);
      }
    });

    test('모든 forcedGrade 값에 대해 올바르게 반환', () {
      for (final grade in HumanGrade.values) {
        final result = drawGrade(
          streak: 3,
          completedYesterday: true,
          cheerReactionCount: 5,
          forcedGrade: grade,
        );
        expect(result, grade);
      }
    });
  });

  group('HumanGrade', () {
    test('label이 올바른 문자열 반환', () {
      expect(HumanGrade.n.label, 'N');
      expect(HumanGrade.r.label, 'R');
      expect(HumanGrade.sr.label, 'SR');
      expect(HumanGrade.ssr.label, 'SSR');
      expect(HumanGrade.ur.label, 'UR');
      expect(HumanGrade.legend.label, 'LEGEND');
    });

    test('fromString 파싱', () {
      expect(HumanGrade.fromString('SR'), HumanGrade.sr);
      expect(HumanGrade.fromString('sr'), HumanGrade.sr);
      expect(HumanGrade.fromString('LEGEND'), HumanGrade.legend);
      expect(HumanGrade.fromString(null), isNull);
      expect(HumanGrade.fromString('UNKNOWN'), isNull);
    });

    test('isHighGrade: SR 이상만 true', () {
      expect(HumanGrade.n.isHighGrade, isFalse);
      expect(HumanGrade.r.isHighGrade, isFalse);
      expect(HumanGrade.sr.isHighGrade, isTrue);
      expect(HumanGrade.ssr.isHighGrade, isTrue);
      expect(HumanGrade.ur.isHighGrade, isTrue);
      expect(HumanGrade.legend.isHighGrade, isTrue);
    });
  });
}
