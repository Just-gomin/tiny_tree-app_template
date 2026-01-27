import 'package:flutter_test/flutter_test.dart';
import 'package:tinytree1769497117188/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('성과 대시보드'), findsOneWidget);
  });
}
