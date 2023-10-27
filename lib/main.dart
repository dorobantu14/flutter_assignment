import 'package:flutter/material.dart';
import 'package:flutter_assignment1/app/app_router.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isUserLoggedIn = await getLoginState();
  runApp(
    MyApp(
      isUserLoggedIn: isUserLoggedIn,
    ),
  );
}

Future<bool> getLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(Strings.isLoggedInText) ?? false;
}

class MyApp extends StatelessWidget {
  final bool _isUserLoggedIn;

  const MyApp({
    super.key,
    required bool isUserLoggedIn,
  }) : _isUserLoggedIn = isUserLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(colorSchemeSeed: AppColors.lightBlue),
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: _isUserLoggedIn ? Strings.mainScreenPath : Strings.loginPath,
        routes: AppRouter.routes,
      ),
    );
  }
}
