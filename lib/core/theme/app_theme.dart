import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const pink = Color(0xFFFF4081);
  static const chocolate = Color(0xFF3E2723);
  static const cream = Color(0xFFFFF9F5);
  static const muted = Color(0xFF9B8882);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: pink,
        primary: pink,
        secondary: chocolate,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: cream,
    );
    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)
          .apply(bodyColor: chocolate, displayColor: chocolate),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: chocolate,
        elevation: 0,
        centerTitle: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: chocolate,
        contentTextStyle: GoogleFonts.poppins(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
