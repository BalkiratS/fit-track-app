import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.child,
  });

  final Widget child;

  static const _padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
