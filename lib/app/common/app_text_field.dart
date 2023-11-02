import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  final String? Function(String?)? validator;
  final String? label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        labelText: label,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
    );
  }
}
