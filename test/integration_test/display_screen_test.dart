import 'package:flutter/material.dart';
import 'package:flutter_assignment1/display_screen/presentation/display_input_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Display screen test', () {
    testWidgets('Test display locations', (tester) async {
      final List<String> locations = ['Singapore', 'Bali'];

      await tester.pumpWidget(
        MaterialApp(
          home: DisplayInputScreen(
            locations: locations,
          ),
        ),
      );

      for (final location in locations) {
        expect(find.text(location), findsOneWidget);
      }
    });
  });
}
