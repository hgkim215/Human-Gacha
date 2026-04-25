import 'package:flutter_test/flutter_test.dart';
import 'package:human_gacha/src/features/draw/mood_select_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('MoodSelectNotifier', () {
    late ProviderContainer container;
    late MoodSelectNotifier notifier;

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(moodSelectProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('초기 상태는 빈 리스트', () {
      expect(container.read(moodSelectProvider), isEmpty);
    });

    test('항목 토글 추가', () {
      notifier.toggle('잠 부족');
      expect(container.read(moodSelectProvider), contains('잠 부족'));
    });

    test('동일 항목 토글 시 제거', () {
      notifier.toggle('잠 부족');
      notifier.toggle('잠 부족');
      expect(container.read(moodSelectProvider), isEmpty);
    });

    test('최대 3개 초과 추가 불가', () {
      notifier.toggle('잠 부족');
      notifier.toggle('카페인 필요');
      notifier.toggle('코테 준비 중');
      notifier.toggle('답장 미룸'); // 4번째 추가 시도

      final state = container.read(moodSelectProvider);
      expect(state.length, 3);
      expect(state.contains('답장 미룸'), isFalse);
    });

    test('clear() 호출 시 초기화', () {
      notifier.toggle('잠 부족');
      notifier.toggle('카페인 필요');
      notifier.clear();
      expect(container.read(moodSelectProvider), isEmpty);
    });
  });
}
