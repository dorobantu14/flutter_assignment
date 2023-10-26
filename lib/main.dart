import 'package:flutter/material.dart';
import 'package:flutter_assignment1/app/app_router.dart';
import 'package:go_router/go_router.dart';

void main() {
  GoRouter router = AppRouter.router;
  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatelessWidget {
  final GoRouter _router;

  const MyApp({
    super.key,
    required GoRouter router,
  }) : _router = router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(colorSchemeSeed: Colors.lightBlueAccent),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
