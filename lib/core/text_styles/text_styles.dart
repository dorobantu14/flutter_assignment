import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';

abstract class TextStyles {
  static const boldSubtitleTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const blackButtonTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.black,
  );

  static const boldGreyTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.lightGrey,
  );
}
