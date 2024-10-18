import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
    headlineLarge: GoogleFonts.montserrat(color: Colors.black87),
    titleMedium: GoogleFonts.poppins(color: Colors.black54,
    fontSize: 24,)
    )
  );
  static ThemeData darkTheme = ThemeData(brightness: Brightness.dark,
   textTheme: TextTheme(
    displayMedium: GoogleFonts.montserrat(color: Colors.white),
    titleMedium: GoogleFonts.poppins(color: Colors.white30,
    fontSize: 24,)
    )
  );
}
