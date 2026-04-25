import 'human_grade.dart';

/// 친구방/전체방 피드 포스트
class RoomPost {
  const RoomPost({
    required this.id,
    required this.nickname,
    required this.grade,
    required this.gradeTitle,
    required this.status,
    this.badgeTitle,
    this.failureTitle,
    this.reactions = const {},
    this.isMe = false,
  });

  final String id;
  final String nickname;
  final HumanGrade grade;
  final String gradeTitle;
  final String status; // 'candidate' | 'success' | 'failure'
  final String? badgeTitle;
  final String? failureTitle;
  final Map<String, int> reactions;
  final bool isMe;

  RoomPost copyWith({
    String? id,
    String? nickname,
    HumanGrade? grade,
    String? gradeTitle,
    String? status,
    String? badgeTitle,
    String? failureTitle,
    Map<String, int>? reactions,
    bool? isMe,
  }) {
    return RoomPost(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      grade: grade ?? this.grade,
      gradeTitle: gradeTitle ?? this.gradeTitle,
      status: status ?? this.status,
      badgeTitle: badgeTitle ?? this.badgeTitle,
      failureTitle: failureTitle ?? this.failureTitle,
      reactions: reactions ?? this.reactions,
      isMe: isMe ?? this.isMe,
    );
  }
}
