import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final bool? buttonEnabled;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.color,
    required this.text,
    this.buttonEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonEnabled ?? true ? onPressed : () {},
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          buttonEnabled ?? true ? color : AppColors.lightGrey,
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(MediaQuery.of(context).size.width, 48),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
