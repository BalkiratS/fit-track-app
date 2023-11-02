import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    this.color = Colors.white,
    this.fontSize = 70.0,
  });

  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Fit Track",
      style: GoogleFonts.pinyonScript(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
