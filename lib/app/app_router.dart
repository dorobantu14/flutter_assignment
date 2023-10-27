import 'package:flutter_assignment1/display_screen/presentation/display_input_screen.dart';
import 'package:flutter_assignment1/login_screen/presentation/login_screen.dart';
import 'package:flutter_assignment1/main_screen/presentation/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static List<GoRoute> get routes => [
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
      ];
}
