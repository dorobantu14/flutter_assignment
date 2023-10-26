import 'package:flutter_assignment1/first_screen/presentation/travel_history_screen.dart';
import 'package:flutter_assignment1/second_screen/presentation/display_locations_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/first_screen',
    routes: [
      GoRoute(
        path: '/first_screen',
        builder: (context, state) => const LastTripsLocations(),
        routes: [
          GoRoute(
            path: 'second_screen',
            builder: (context, state) {
              final locations = state.extra as List<String>;
              return DisplayLocationsScreen(locations: locations);
            },
          ),
        ],
      )
    ],
  );

  static GoRouter get router => _router;
}
