import 'package:flutter_assignment1/first_screen/presentation/travel_history_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LastTripsLocations(),
      )
    ],
  );

  static GoRouter get router => _router;
}
