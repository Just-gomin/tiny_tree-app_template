import 'package:flutter_test/flutter_test.dart';
import 'package:project_1768556464395/app.dart';

void main() {
  testWidgets('Game screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('가위바위보 게임'), findsOneWidget);
  });
}
