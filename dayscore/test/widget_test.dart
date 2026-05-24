import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dayscore/app.dart';

void main() {
  testWidgets('DayScore app initialization smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: DayScoreApp(),
      ),
    );

    // Verify that Splash Screen contents load (expects 2 matching widgets)
    expect(find.text('DayScore'), findsNWidgets(2));

    // Allow the splash navigation timer (2.8s) to fire and finish
    await tester.pumpAndSettle(const Duration(milliseconds: 3000));
  });
}
