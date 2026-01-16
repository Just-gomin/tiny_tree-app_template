import 'package:flutter_test/flutter_test.dart';
import 'package:mvp_https_official_joke_1768533558682/app.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Random Joke 🎭'), findsOneWidget);
  });
}
