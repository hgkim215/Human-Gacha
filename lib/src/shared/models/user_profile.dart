/// 사용자 프로필 (온보딩 결과)
class UserProfile {
  const UserProfile({
    required this.nickname,
    required this.persona,
    required this.mainStruggles,
    required this.difficulty,
    required this.tone,
    this.streak = 0,
    this.egoShards = 0,
    this.humanityGauge = 50,
    this.onboardingCompleted = false,
  });

  final String nickname;
  final String persona;
  final List<String> mainStruggles;
  final String difficulty; // easy / normal / hard
  final String tone; // gentle / roast / public
  final int streak;
  final int egoShards;
  final int humanityGauge;
  final bool onboardingCompleted;

  /// P0 데모 기본 사용자
  static const demo = UserProfile(
    nickname: '현기',
    persona: '취준 인간',
    mainStruggles: ['코테', '운동', '답장'],
    difficulty: 'normal',
    tone: 'roast',
    streak: 3,
    egoShards: 42,
    humanityGauge: 80,
    onboardingCompleted: true,
  );

  UserProfile copyWith({
    String? nickname,
    String? persona,
    List<String>? mainStruggles,
    String? difficulty,
    String? tone,
    int? streak,
    int? egoShards,
    int? humanityGauge,
    bool? onboardingCompleted,
  }) {
    return UserProfile(
      nickname: nickname ?? this.nickname,
      persona: persona ?? this.persona,
      mainStruggles: mainStruggles ?? this.mainStruggles,
      difficulty: difficulty ?? this.difficulty,
      tone: tone ?? this.tone,
      streak: streak ?? this.streak,
      egoShards: egoShards ?? this.egoShards,
      humanityGauge: humanityGauge ?? this.humanityGauge,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'persona': persona,
    'mainStruggles': mainStruggles,
    'difficulty': difficulty,
    'tone': tone,
    'streak': streak,
    'egoShards': egoShards,
    'humanityGauge': humanityGauge,
    'onboardingCompleted': onboardingCompleted,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nickname: json['nickname'] as String? ?? '나',
      persona: json['persona'] as String? ?? '그냥 생존 인간',
      mainStruggles: List<String>.from(json['mainStruggles'] as List? ?? []),
      difficulty: json['difficulty'] as String? ?? 'easy',
      tone: json['tone'] as String? ?? 'gentle',
      streak: json['streak'] as int? ?? 0,
      egoShards: json['egoShards'] as int? ?? 0,
      humanityGauge: json['humanityGauge'] as int? ?? 50,
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
    );
  }
}
