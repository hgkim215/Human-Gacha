import 'human_grade.dart';

/// AI 또는 fallback으로 생성된 인간 카드 데이터
class HumanCard {
  const HumanCard({
    required this.grade,
    required this.gradeTitle,
    required this.description,
    required this.mission,
    required this.successBadge,
    required this.failureTitle,
    required this.failureMessage,
    required this.shareText,
    this.isFallback = false,
  });

  final HumanGrade grade;
  final String gradeTitle;
  final String description;
  final String mission;
  final String successBadge;
  final String failureTitle;
  final String failureMessage;
  final String shareText;
  final bool isFallback;

  factory HumanCard.fromJson(Map<String, dynamic> json, HumanGrade grade) {
    return HumanCard(
      grade: grade,
      gradeTitle: _truncate(json['gradeTitle'] as String? ?? '', 60),
      description: _truncate(json['description'] as String? ?? '', 120),
      mission: _truncate(json['mission'] as String? ?? '', 100),
      successBadge: _truncate(json['successBadge'] as String? ?? '', 40),
      failureTitle: _truncate(json['failureTitle'] as String? ?? '', 40),
      failureMessage: _truncate(json['failureMessage'] as String? ?? '', 80),
      shareText: _truncate(json['shareText'] as String? ?? '', 80),
    );
  }

  static String _truncate(String s, int max) {
    if (s.isEmpty) return s;
    return s.length > max ? s.substring(0, max) : s;
  }

  bool get isValid =>
      gradeTitle.isNotEmpty &&
      description.isNotEmpty &&
      mission.isNotEmpty &&
      successBadge.isNotEmpty &&
      failureTitle.isNotEmpty;

  HumanCard copyWith({
    HumanGrade? grade,
    String? gradeTitle,
    String? description,
    String? mission,
    String? successBadge,
    String? failureTitle,
    String? failureMessage,
    String? shareText,
    bool? isFallback,
  }) {
    return HumanCard(
      grade: grade ?? this.grade,
      gradeTitle: gradeTitle ?? this.gradeTitle,
      description: description ?? this.description,
      mission: mission ?? this.mission,
      successBadge: successBadge ?? this.successBadge,
      failureTitle: failureTitle ?? this.failureTitle,
      failureMessage: failureMessage ?? this.failureMessage,
      shareText: shareText ?? this.shareText,
      isFallback: isFallback ?? this.isFallback,
    );
  }
}
