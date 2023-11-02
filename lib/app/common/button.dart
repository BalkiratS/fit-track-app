import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  static const _horizontalPad = 75.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(
          left: _horizontalPad,
          right: _horizontalPad,
        ),
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
