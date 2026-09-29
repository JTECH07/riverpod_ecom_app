import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6C5CE7),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6C5CE7),
      onPrimary: Colors.white,
      secondary: Color(0xFF00CEA9),
      onSecondary: Colors.black,
      error: Color(0xFFEF4444),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF6C5CE7),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF6C5CE7),
      onPrimary: Colors.white,
      secondary: Color(0xFF00CEA9),
      onSecondary: Colors.white,
      error: Color(0xFFEF4444),
      onError: Colors.white,
      surface: Color(0xFF1E293B),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF0F172A),
  );
}