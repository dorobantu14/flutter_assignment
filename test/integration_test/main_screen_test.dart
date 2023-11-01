import 'package:flutter/material.dart';
import 'package:flutter_assignment1/login_screen/presentation/login_screen.dart';
import 'package:flutter_assignment1/main_screen/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('main screen test', () {
    testWidgets('Main page tap on input tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainScreen(),
        ),
      );

      // Get input tab and tap
      final inputTabFinder = find.text('Input');
      await tester.pump();
      await tester.tap(inputTabFinder);
      await tester.pumpAndSettle();

      // Check if input screen is displayed
      final inputScreenFinder = find.text('Share Your Travel History');
      expect(inputScreenFinder, findsNothing);
    });

    testWidgets('Main page tap person test', (WidgetTester tester) async {
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

      // Check if input screen is displayed
      final inputScreenFinder = find.text('Share Your Travel History');
      expect(inputScreenFinder, findsOneWidget);
    });

    testWidgets('Main page logout test', (WidgetTester tester) async {
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
          )
        ],
      );
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: mockRouter,
        ),
      );

      // Tap logout button
      final logoutButtonFinder = find.byIcon(Icons.logout);
      await tester.pump();
      await tester.tap(logoutButtonFinder);
      await tester.pumpAndSettle();

      // Check if login screen is displayed
      final loginScreenFinder = find.text('Login');
      expect(loginScreenFinder, findsOneWidget);
    });
  });
}
