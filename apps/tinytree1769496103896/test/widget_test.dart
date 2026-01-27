import 'package:flutter_test/flutter_test.dart';
import 'package:tinytree1769496103896/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('대시보드'), findsOneWidget);
  });
}
