import '../../shared/models/human_grade.dart';
import '../../shared/models/room_post.dart';

/// 친구방 더미 피드 데이터 (발표용 무대)
class DummyFeedData {
  const DummyFeedData._();

  static List<RoomPost> friendPosts = [
    const RoomPost(
      id: 'friend_1',
      nickname: '지환',
      grade: HumanGrade.n,
      gradeTitle: 'N 침대 협상가',
      status: 'failure',
      failureTitle: '물에게 진 사람',
      reactions: {'인정': 5, '내 얘기임': 8, '지켜본다': 2},
    ),
    const RoomPost(
      id: 'friend_2',
      nickname: '수빈',
      grade: HumanGrade.r,
      gradeTitle: 'R 카페인 의존형 인간',
      status: 'candidate',
      reactions: {'인정': 3, '구라 ㄴ': 1, '지켜본다': 4},
    ),
    const RoomPost(
      id: 'friend_3',
      nickname: '태현',
      grade: HumanGrade.ssr,
      gradeTitle: 'SSR 오전 부팅 성공자',
      status: 'success',
      badgeTitle: '오전 부팅 성공자',
      reactions: {'인정': 12, '인간 승리': 7, '구라 ㄴ': 3},
    ),
    const RoomPost(
      id: 'friend_4',
      nickname: '민서',
      grade: HumanGrade.sr,
      gradeTitle: 'SR 계획적인 취준 인간',
      status: 'candidate',
      reactions: {'인정': 6, '지켜본다': 9, '실패 예약': 2},
    ),
  ];

  /// 내 결과를 피드 맨 위에 추가
  static List<RoomPost> withMyPost(RoomPost myPost) {
    return [myPost, ...friendPosts];
  }

  /// 전체방 더미 통계
  static const wholeRoomStats = (
    nPercent: 52,
    mostFailedMission: '물 마시기',
    totalUsers: 1284,
    legendCount: 2,
    srOrAbovePercent: 23,
  );

  static const wholeRoomPosts = [
    (
      nickname: '오늘의 LEGEND',
      grade: HumanGrade.legend,
      title: 'LEGEND 지원서 쓰고 코테 풀고 씻은 사람',
      badge: '오늘의 대표 인간',
    ),
    (
      nickname: '오늘의 픽업 성공자',
      grade: HumanGrade.ssr,
      title: 'SSR 오전 부팅 성공자',
      badge: '오전 부팅 성공자',
    ),
  ];
}
