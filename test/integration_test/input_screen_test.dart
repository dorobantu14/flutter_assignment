import 'package:flutter/material.dart';
import 'package:flutter_assignment1/display_screen/presentation/display_input_screen.dart';
import 'package:flutter_assignment1/login_screen/presentation/login_screen.dart';
import 'package:flutter_assignment1/main_screen/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Input screen test', () {
    testWidgets('Add location test', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainScreen(),
        ),
      );
      // Find first person and tap
      final personFinder = find.byType(GestureDetector).first;
      await tester.pump();
      await tester.tap(personFinder);
      await tester.pumpAndSettle();

      // Find the location input field
      final locationFieldFinder = find.widgetWithText(TextFormField, 'Location');

      // Enter a valid location
      await tester.enterText(locationFieldFinder, 'Singapore');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Check if location is added
      expect(find.text('Singapore'), findsOneWidget);

      // Enter a valid location
      await tester.enterText(locationFieldFinder, 'Bali');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Check if location is added
      expect(find.text('Bali'), findsOneWidget);
    });

    testWidgets('Test continue button', (tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/main_screen',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: '/main_screen',
            builder: (context, state) => const MainScreen(),
            routes: [
              GoRoute(
                path: 'display_screen',
                builder: (context, state) {
                  final locations = state.extra as List<String>;
                  return DisplayInputScreen(locations: locations);
                },
              ),
            ],
          )
        ],
      );
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: mockRouter,
        ),
      );
      // Find first person and tap
      final personFinder = find.byType(GestureDetector).first;
      await tester.pump();
      await tester.tap(personFinder);
      await tester.pumpAndSettle();

      // Find the location input field
      final locationFieldFinder = find.widgetWithText(TextFormField, 'Location');
      final continueButtonFinder = find.text('Continue');

      // Tap the continue button
      await tester.tap(continueButtonFinder);
      await tester.pumpAndSettle();

      // Check if navigation is not done
      expect(find.text('Share Your Travel History'), findsOneWidget);

      // Enter a valid location
      await tester.enterText(locationFieldFinder, 'Singapore');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Tap the continue button
      await tester.tap(continueButtonFinder);
      await tester.pumpAndSettle();

      // Check if display screen is displayed
      expect(find.text('Last trips locations'), findsOneWidget);
    });
  });
}
