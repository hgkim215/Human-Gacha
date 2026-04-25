import '../../shared/models/human_card.dart';
import '../../shared/models/human_grade.dart';
import '../../features/demo_mode/demo_seed.dart';

/// AI 실패 시 즉시 반환하는 fallback 카드 서비스
class FallbackCardService {
  const FallbackCardService._();

  /// 등급에 맞는 fallback 카드 반환 (항상 동기)
  static HumanCard getCard(HumanGrade grade) {
    return DemoSeed.forGrade(grade);
  }
}
