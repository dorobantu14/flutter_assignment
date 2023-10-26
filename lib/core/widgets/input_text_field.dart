import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final VoidCallback? onEditCompleted;

  const AppTextField({
    Key? key,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    required this.controller,
    this.onEditCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization:TextCapitalization.sentences,
      onEditingComplete: onEditCompleted,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
