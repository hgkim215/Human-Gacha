import 'package:flutter_test/flutter_test.dart';

import 'package:human_gacha/main.dart';

void main() {
  testWidgets('renders app shell', (tester) async {
    await tester.pumpWidget(const HumanGachaApp());

    expect(find.text('Human Gacha'), findsOneWidget);
  });
}
