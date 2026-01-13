// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:neon_tetris_mvp_1768288059189/main.dart';

void main() {
  testWidgets('Neon Tetris app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NeonTetrisApp());
    expect(find.text('⚡ NEON TETRIS ⚡'), findsOneWidget);
  });
}
