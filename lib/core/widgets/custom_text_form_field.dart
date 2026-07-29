import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    this.obscureText = false,
    this.readonly = false,
    this.onTap,
  });
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final bool readonly;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hintText),
      validator: validator,
      onSaved: onSaved,
      readOnly: readonly,
      onTap: onTap,
    );
  }
}
