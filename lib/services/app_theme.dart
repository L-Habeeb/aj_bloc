import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: Colors.black,
        surface: Color(0xFF212121), // changed from background
      ),

      dividerColor: Colors.black54,

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white), 
        ),
      ),

      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        unselectedItemColor: Colors.white,
      ),
    ),

    AppTheme.lightTheme: ThemeData(
      brightness: Brightness.light,

      colorScheme: const ColorScheme.light(
        primary: Colors.white,
        surface: Color(0xFFE5E5E5), // changed from background
      ),

      dividerColor: Color(0xff757575),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.black),
        ),
      ),

      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
      ),
    ),
  };

  AppThemes(AppTheme darkTheme);
}
