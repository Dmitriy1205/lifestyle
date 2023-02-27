import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    dividerColor: const Color(0xFFC7ED3A),
    colorScheme:
        ThemeData().colorScheme.copyWith(primary: const Color(0xFF10284D)),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      labelColor: Color(0xFF10284D),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      unselectedLabelColor: Color(0xFF898D94),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Color(0xFF10284D)),
    inputDecorationTheme: const InputDecorationTheme(
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        color: Color(0xFF10284D),
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color(0xFF10284D),
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Color(0xFF10284D),
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color(0xFF898D94),
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Color(0xFF10284D),
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color(0xFF898D94),
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 19,
        color: Color(0xFF10284D),
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Color(0xFFFFFFFF),
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: Color(0xFF10284D),
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: Color(0xFF10284D),
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xFFC7ED3A),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: Color(0xFF10284D),
        ),
        backgroundColor: const Color(0xFFC7ED3A),
      ),
    ),
  );
}
