import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: Color(0xFF10284D)),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFF10284D)),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Color(0xFF10284D),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Color(0xFF898D94),
      )),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF10284D),
        ),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Color(0xFFFF0000),
      )),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
        color: Color(0xFFFF0000),
      )),
    ),
    useMaterial3: true,
    fontFamily: 'Lato',
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        color: Color(0xFF10284D),
      ),
      displayMedium: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color(0xFF10284D),
      ),
      titleLarge: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Color(0xFF10284D),
      ),
      titleMedium: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color(0xFF898D94),
      ),
      displaySmall: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color(0xFF898D94),
      ),
      bodyMedium: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Color(0xFFFFFFFF),
      ),
      labelLarge: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: Color(0xFF10284D),
      ),
      labelSmall: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: Color(0xFF10284D),
      ),
      labelMedium: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xFFC7ED3A),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: BeveledRectangleBorder(),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: Color(0xFF10284D),
        ),
        backgroundColor: Color(0xFFC7ED3A),
      ),
    ),
  );
}
