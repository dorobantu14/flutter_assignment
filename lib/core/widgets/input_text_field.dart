import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final String? errorText;
  final TextEditingController controller;
  final VoidCallback? onEditCompleted;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const AppTextField({
    Key? key,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    required this.controller,
    this.onEditCompleted,
    this.errorText,
    this.onChanged,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: onEditCompleted,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        errorText: errorText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
