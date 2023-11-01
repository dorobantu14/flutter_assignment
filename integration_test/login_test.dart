import 'package:flutter/material.dart';
import 'package:flutter_assignment1/login_screen/presentation/login_screen.dart';
import 'package:flutter_assignment1/main_screen/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Login invalid credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Find the email and password input fields
      final emailFieldFinder = find.widgetWithText(Form, 'Email');
      final passwordFieldFinder = find.widgetWithText(Form, 'Password');

      // Find the login button
      final loginButtonFinder = find.text('Sign in');

      // Initially, both fields should be empty, and the button should be disabled
      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsNothing);
      expect(find.text('Password not strong enough'), findsNothing);

      // Enter invalid email and password, and the button should still be disabled
      await tester.enterText(emailFieldFinder, 'email');
      await tester.enterText(passwordFieldFinder, 'weak');
      await tester.pump();

      // Submit login form
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();

      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsOneWidget);
      expect(find.text('Password not strong enough'), findsOneWidget);
    });

    testWidgets('Login invalid email and valid password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Find the email and password input fields
      final emailFieldFinder = find.widgetWithText(Form, 'Email');
      final passwordFieldFinder = find.widgetWithText(Form, 'Password');

      // Find the login button
      final loginButtonFinder = find.text('Sign in');

      // Initially, both fields should be empty, and the button should be disabled
      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsNothing);
      expect(find.text('Password not strong enough'), findsNothing);

      // Enter invalid email and  valid password, and the button should still be disabled
      await tester.enterText(emailFieldFinder, 'email');
      await tester.enterText(passwordFieldFinder, 'StrongP@ss1');
      await tester.pump();

      // Submit login form
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();

      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsOneWidget);
      expect(find.text('Password not strong enough'), findsNothing);
    });

    testWidgets('Login valid email and invalid password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      // Find the email and password input fields
      final emailFieldFinder = find.widgetWithText(Form, 'Email');
      final passwordFieldFinder = find.widgetWithText(Form, 'Password');

      // Find the login button
      final loginButtonFinder = find.text('Sign in');

      // Initially, both fields should be empty, and the button should be disabled
      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsNothing);
      expect(find.text('Password not strong enough'), findsNothing);

      // Enter valid email and invalid password, and the button should still be disabled
      await tester.enterText(emailFieldFinder, 'example@example.com');
      await tester.enterText(passwordFieldFinder, 'weak');
      await tester.pump();

      // Submit login form
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();

      expect(loginButtonFinder, findsOneWidget);
      expect(find.text('Email should look like: user@xxx.com'), findsNothing);
      expect(find.text('Password not strong enough'), findsOneWidget);
    });

    testWidgets('Login visible password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginScreen(),
        ),
      );

      final visibilityButtonFinder = find.byIcon(Icons.visibility);
      final visibilityOffButtonFinder = find.byIcon(Icons.visibility_off);
      await tester.enterText(find.widgetWithText(Form, 'Password'), 'StrongP@ss1');
      final passwordFieldFinder = find.descendant(
        of: find.widgetWithText(TextFormField, 'Password'),
        matching: find.byType(TextField),
      );

      await tester.tap(visibilityButtonFinder);
      await tester.pumpAndSettle();

      // Verify that the text is not obscured
      expect(
        tester.firstWidget<TextField>(passwordFieldFinder).obscureText,
        false,
      );
      await tester.tap(visibilityOffButtonFinder);
      await tester.pumpAndSettle();

      // Verify that the text is obscured again
      expect(
        tester.firstWidget<TextField>(passwordFieldFinder).obscureText,
        true,
      );
    });

    testWidgets('Login with valid credentials', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/login',
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

      SharedPreferences.setMockInitialValues({'isLoggedIn': false});

      // Find the email and password input fields
      final emailFieldFinder = find.widgetWithText(Form, 'Email');
      final passwordFieldFinder = find.widgetWithText(Form, 'Password');

      // Find the login button
      final loginButtonFinder = find.text('Sign in');

      // Initially, both fields should be empty, and the button should be disabled
      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);
      expect(loginButtonFinder, findsOneWidget);

      // Enter a valid password and email
      await tester.enterText(emailFieldFinder, 'example@example.com');
      await tester.enterText(passwordFieldFinder, 'StrongP@ss1');
      await tester.pump();

      // Submit the form
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsNothing);
    });
  });
}
