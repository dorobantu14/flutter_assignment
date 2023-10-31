// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_assignment1/login_screen/presentation/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login with valid credentials', (WidgetTester tester) async {
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

    // Enter a valid password and email
    await tester.enterText(emailFieldFinder, 'example@example.com');
    await tester.enterText(passwordFieldFinder, 'StrongP@ss1');
    await tester.pump();

    // Submit the form
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();

    // Check if credentials are correct
    expect(loginButtonFinder, findsOneWidget);
    expect(find.text('Email should look like: user@xxx.com'), findsNothing);
    expect(find.text('Password not strong enough'), findsNothing);

    // Submit the form
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();
  });

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

  testWidgets('Login valid email and invalid password', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home:LoginScreen(),
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

  testWidgets('Login visible password', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    final visibilityButtonFinder = find.byIcon(Icons.visibility);
    final visibilityOffButtonFinder = find.byIcon(Icons.visibility_off);
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
}
