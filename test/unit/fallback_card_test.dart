import 'package:flutter_test/flutter_test.dart';
import 'package:human_gacha/src/shared/models/human_grade.dart';
import 'package:human_gacha/src/shared/services/fallback_card_service.dart';

void main() {
  group('FallbackCardService', () {
    test('모든 등급에 대해 카드 반환', () {
      for (final grade in HumanGrade.values) {
        final card = FallbackCardService.getCard(grade);
        expect(card.grade, grade);
        expect(card.isValid, isTrue);
        expect(card.isFallback, isTrue);
      }
    });

    test('카드 필수 필드가 비어있지 않음', () {
      for (final grade in HumanGrade.values) {
        final card = FallbackCardService.getCard(grade);
        expect(card.gradeTitle, isNotEmpty);
        expect(card.description, isNotEmpty);
        expect(card.mission, isNotEmpty);
        expect(card.successBadge, isNotEmpty);
        expect(card.failureTitle, isNotEmpty);
        expect(card.failureMessage, isNotEmpty);
        expect(card.shareText, isNotEmpty);
      }
    });
  });
}
