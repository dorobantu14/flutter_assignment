import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const AppBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.arrow_back,
        size: 32,
        color: AppColors.lightGrey,
      ),
    );
  }
}