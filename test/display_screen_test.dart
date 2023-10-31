import 'package:flutter/material.dart';
import 'package:flutter_assignment1/display_screen/presentation/display_input_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<String> locations = ['Singapore', 'Bali'];
  testWidgets('Test display locations', (tester) async {
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
}
