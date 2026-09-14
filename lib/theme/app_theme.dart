import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0F1115),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
    ),
  );
}
