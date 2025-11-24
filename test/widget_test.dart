import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academic_manager_icade/main.dart';

void main() {
  testWidgets('App widget can be instantiated', (WidgetTester tester) async {
    // Build our app widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify the app widget was created
    expect(find.byType(MyApp), findsOneWidget);
  });
}
