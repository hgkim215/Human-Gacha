import 'human_card.dart';
import 'human_grade.dart';

enum DrawStatus { inProgress, success, failure }

/// 뽑기 세션 결과 (카드 + 오늘 상태 + 처리 상태)
class DrawResult {
  const DrawResult({
    required this.card,
    required this.todayMood,
    this.status = DrawStatus.inProgress,
    this.egoShardsRewarded = 0,
  });

  final HumanCard card;
  final List<String> todayMood;
  final DrawStatus status;
  final int egoShardsRewarded;

  HumanGrade get grade => card.grade;

  DrawResult copyWith({
    HumanCard? card,
    List<String>? todayMood,
    DrawStatus? status,
    int? egoShardsRewarded,
  }) {
    return DrawResult(
      card: card ?? this.card,
      todayMood: todayMood ?? this.todayMood,
      status: status ?? this.status,
      egoShardsRewarded: egoShardsRewarded ?? this.egoShardsRewarded,
    );
  }

  int get successEgoShards {
    switch (grade) {
      case HumanGrade.n:
        return 1;
      case HumanGrade.r:
        return 3;
      case HumanGrade.sr:
        return 8;
      case HumanGrade.ssr:
        return 15;
      case HumanGrade.ur:
        return 30;
      case HumanGrade.legend:
        return 100;
    }
  }

  int get failureEgoShards {
    switch (grade) {
      case HumanGrade.n:
        return 1;
      case HumanGrade.r:
        return 1;
      case HumanGrade.sr:
        return 2;
      case HumanGrade.ssr:
        return 3;
      case HumanGrade.ur:
        return 5;
      case HumanGrade.legend:
        return 10;
    }
  }
}
