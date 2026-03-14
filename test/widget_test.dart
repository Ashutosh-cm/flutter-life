import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/main.dart';

void main() {
  testWidgets('Notes App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if our Home Screen title appears
    expect(find.text("What's on your mind"), findsOneWidget);
  });
}