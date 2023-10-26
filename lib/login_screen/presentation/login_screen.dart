import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/text_styles/text_styles.dart';
import 'package:flutter_assignment1/core/widgets/app_button.dart';
import 'package:flutter_assignment1/core/widgets/input_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.addListener(refreshCallback);
    passwordController.addListener(refreshCallback);
  }

  void refreshCallback() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getLoginIcon(),
                getLoginTitle(),
                getEmailField(),
                getPasswordField(),
                getLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoginTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.loginText,
          style: TextStyles.boldSubtitleTextStyle,
        ),
        Text(Strings.pleaseSignInText),
      ],
    );
  }

  Widget getLoginIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Strings.loginIconPath,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }

  String? isPasswordValid(String? password) {
    const lengthRequirement = 8;
    final uppercasePattern = RegExp(r'[A-Z]');
    final lowercasePattern = RegExp(r'[a-z]');
    final digitPattern = RegExp(r'[0-9]');
    final specialCharPattern = RegExp(r'[!@#$%^&*(),.?":{}|<>-]');

    final hasLength = password!.length >= lengthRequirement;
    final hasUppercase = uppercasePattern.hasMatch(password);
    final hasLowercase = lowercasePattern.hasMatch(password);
    final hasDigit = digitPattern.hasMatch(password);
    final hasSpecialChar = specialCharPattern.hasMatch(password);

    if (hasLength && hasUppercase && hasLowercase && hasDigit && hasSpecialChar) {
      return null;
    }
    return 'Password not strong enough';
  }

  Widget getPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Form(
        key: _passwordKey,
        child: AppTextField(
          hintText: 'Password',
          obscureText: !isPasswordVisible,
          suffixIcon: getVisibilityIcon(),
          controller: passwordController,
          validator: isPasswordValid,
        ),
      ),
    );
  }

  Widget getVisibilityIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      child: isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
    );
  }

  Widget getEmailField() => Form(
        key: _emailKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: AppTextField(
            hintText: 'Email',
            controller: emailController,
            validator: isEmailValid,
          ),
        ),
      );

  String? isEmailValid(String? email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email ?? '')) {
      return 'Email should look like: user@xxx.com';
    }
    return null;
  }

  Future<void> setLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Widget getLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 44, left: 24, right: 24),
      child: AppButton(
        onPressed: () async {
          final bool validEmail = _emailKey.currentState!.validate();
          final bool validPassword = _passwordKey.currentState!.validate();
          if (validEmail && validPassword) {
            await setLoginState(true).then(
              (value) => context.go('/main_screen'),
            );
          }
        },
        buttonEnabled: emailController.text.isNotEmpty && passwordController.text.isNotEmpty,
        color: AppColors.blue,
        text: Strings.signInText,
      ),
    );
  }
}
