import 'dart:math';

/// 인간 등급 enum
enum HumanGrade {
  n,
  r,
  sr,
  ssr,
  ur,
  legend;

  String get label {
    switch (this) {
      case HumanGrade.n:
        return 'N';
      case HumanGrade.r:
        return 'R';
      case HumanGrade.sr:
        return 'SR';
      case HumanGrade.ssr:
        return 'SSR';
      case HumanGrade.ur:
        return 'UR';
      case HumanGrade.legend:
        return 'LEGEND';
    }
  }

  String get displayColor {
    switch (this) {
      case HumanGrade.n:
        return '#9E9E9E';
      case HumanGrade.r:
        return '#66BB6A';
      case HumanGrade.sr:
        return '#42A5F5';
      case HumanGrade.ssr:
        return '#AB47BC';
      case HumanGrade.ur:
        return '#FF7043';
      case HumanGrade.legend:
        return '#FFD700';
    }
  }

  bool get isHighGrade => index >= HumanGrade.sr.index;

  static HumanGrade? fromString(String? s) {
    switch (s?.toUpperCase()) {
      case 'N':
        return HumanGrade.n;
      case 'R':
        return HumanGrade.r;
      case 'SR':
        return HumanGrade.sr;
      case 'SSR':
        return HumanGrade.ssr;
      case 'UR':
        return HumanGrade.ur;
      case 'LEGEND':
        return HumanGrade.legend;
      default:
        return null;
    }
  }
}

/// 확률 기반 등급 뽑기 (Demo Mode에서는 forcedGrade 우선)
HumanGrade drawGrade({
  required int streak,
  required bool completedYesterday,
  required int cheerReactionCount,
  HumanGrade? forcedGrade,
}) {
  if (forcedGrade != null) {
    return forcedGrade;
  }

  final rates = <HumanGrade, double>{
    HumanGrade.n: 45.0,
    HumanGrade.r: 30.0,
    HumanGrade.sr: 15.0,
    HumanGrade.ssr: 8.0,
    HumanGrade.ur: 1.8,
    HumanGrade.legend: 0.2,
  };

  if (completedYesterday) {
    rates[HumanGrade.n] = rates[HumanGrade.n]! - 3;
    rates[HumanGrade.sr] = rates[HumanGrade.sr]! + 2;
    rates[HumanGrade.ssr] = rates[HumanGrade.ssr]! + 0.8;
    rates[HumanGrade.ur] = rates[HumanGrade.ur]! + 0.2;
  }

  if (streak >= 3) {
    rates[HumanGrade.n] = rates[HumanGrade.n]! - 2;
    rates[HumanGrade.r] = rates[HumanGrade.r]! + 1;
    rates[HumanGrade.sr] = rates[HumanGrade.sr]! + 1;
  }

  if (cheerReactionCount >= 3) {
    rates[HumanGrade.ssr] = rates[HumanGrade.ssr]! + 0.5;
    rates[HumanGrade.n] = rates[HumanGrade.n]! - 0.5;
  }

  final total = rates.values.reduce((a, b) => a + b);
  final random = Random().nextDouble() * total;

  double cumulative = 0;
  for (final entry in rates.entries) {
    cumulative += entry.value;
    if (random <= cumulative) {
      return entry.key;
    }
  }

  return HumanGrade.n;
}
