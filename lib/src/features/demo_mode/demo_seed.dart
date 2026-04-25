import '../../shared/models/human_card.dart';
import '../../shared/models/human_grade.dart';

/// 고정 데모 시드 카드 (AI 호출 없이도 데모 루프 완주)
class DemoSeed {
  const DemoSeed._();

  static const srCard = HumanCard(
    grade: HumanGrade.sr,
    gradeTitle: 'SR 계획적인 취준 인간',
    description: '계획표를 열었고, 아직 도망가지 않았습니다.\n이 정도면 오늘의 사회적 생존 가능성이 있습니다.',
    mission: '코테 문제를 다 풀지 않아도 좋으니 풀이를 15분만 읽으세요.',
    successBadge: '도망은 안 간 사람',
    failureTitle: 'SR인 척한 사람',
    failureMessage: '계획은 있었으나 실행 파일이 누락되었습니다.',
    shareText: '오늘 나는 SR 계획적인 취준 인간 후보입니다.',
    isFallback: true,
  );

  static const ssrCard = HumanCard(
    grade: HumanGrade.ssr,
    gradeTitle: 'SSR 오전 부팅 성공자',
    description: '오전에 움직였다는 제보가 들어왔습니다.\n현재 인간성 서버가 혼란스러워하고 있습니다.',
    mission: '이력서 한 문단을 열고, 딱 5줄만 고쳐 쓰세요.',
    successBadge: '오전 부팅 성공자',
    failureTitle: '부팅 화면에서 멈춘 사람',
    failureMessage: '시작 버튼은 눌렀으나 로딩 중에 멈췄습니다.',
    shareText: '오늘 나는 SSR 오전 부팅 성공자 후보입니다.',
    isFallback: true,
  );

  static const nCard = HumanCard(
    grade: HumanGrade.n,
    gradeTitle: 'N 침대 협상가',
    description: '오늘도 침대와의 긴 협상을 마치고 일어났습니다.\n협상 결과: 5분 추가 확보.',
    mission: '물 한 컵을 마세요. 그게 전부입니다.',
    successBadge: '수분은 섭취한 사람',
    failureTitle: '물에게 진 사람',
    failureMessage: '물 한 컵도 없었습니다. 내일은 꼭 드세요.',
    shareText: '오늘 나는 N 침대 협상가 후보입니다.',
    isFallback: true,
  );

  static const rCard = HumanCard(
    grade: HumanGrade.r,
    gradeTitle: 'R 카페인 의존형 인간',
    description: '커피 없이는 기동 불가. 오늘도 카페인과의 공생 관계를 이어갑니다.',
    mission: '책상 위 물건 3개를 제자리에 치워 보세요.',
    successBadge: '책상과 화해한 사람',
    failureTitle: '책상과 휴전한 사람',
    failureMessage: '정리는 내일로 미뤄졌습니다. 익숙한 결말입니다.',
    shareText: '오늘 나는 R 카페인 의존형 인간 후보입니다.',
    isFallback: true,
  );

  /// 등급에 맞는 고정 시드 카드 반환
  static HumanCard forGrade(HumanGrade grade) {
    switch (grade) {
      case HumanGrade.n:
        return nCard;
      case HumanGrade.r:
        return rCard;
      case HumanGrade.sr:
        return srCard;
      case HumanGrade.ssr:
        return ssrCard;
      case HumanGrade.ur:
        return _urCard;
      case HumanGrade.legend:
        return _legendCard;
    }
  }

  static const _urCard = HumanCard(
    grade: HumanGrade.ur,
    gradeTitle: 'UR 빨래까지 한 사람',
    description: '운동복을 입고 실제로 씻기까지 완료.\n역사에 기록될 위업입니다.',
    mission: '운동복 입고 10분 걷기 + 샤워까지.',
    successBadge: '오늘의 인류 대표',
    failureTitle: '인류 대표 탈락자',
    failureMessage: '아쉽습니다. 다음 기회에 인류를 대표해 주세요.',
    shareText: '오늘 나는 UR 빨래까지 한 사람 후보입니다.',
    isFallback: true,
  );

  static const _legendCard = HumanCard(
    grade: HumanGrade.legend,
    gradeTitle: 'LEGEND 지원서 쓰고 코테 풀고 씻은 사람',
    description: '이것은 실화입니까?\n인간성 측정 시스템이 과부하 상태입니다.',
    mission: '지원서 1개를 제출하세요. 딱 1개.',
    successBadge: '오늘의 대표 인간',
    failureTitle: '전설 예고편',
    failureMessage: '이번엔 예고편이었습니다. 다음 편에서 봐요.',
    shareText: '오늘 나는 LEGEND 후보입니다. 믿기 어렵죠.',
    isFallback: true,
  );

  /// 오늘의 픽업 인간 2개 (홈 화면용)
  static const pickupHumans = [
    (grade: HumanGrade.ssr, title: 'SSR 오전 부팅 성공자'),
    (grade: HumanGrade.ur, title: 'UR 빨래까지 한 사람'),
  ];

  /// 확률 버프 목록
  static const buffs = ['어제 미션 성공: SR 이상 확률 +3%', '3일 연속 접속: N 확률 -2%'];
}
