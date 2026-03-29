// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:vvk_salon/main.dart';

void main() {
  testWidgets('WebView load smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VVKSalonApp());

    // Verify that the title is present.
    expect(find.text('VVK SALON'), findsOneWidget);
    
    // On non-mobile tests, it should show the fallback message.
    expect(find.textContaining('Mobile'), findsOneWidget);
  });
}
