import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Custom themes for the app
class AppThemes {

  /// Dark theme used by the app
  static ThemeData get darkTheme {

    return ThemeData(
      brightness: Brightness.dark,

      primaryColor: AppColors.insidersColorsInsidersBlue,
      primarySwatch: AppColors.insidersColorsInsidersBlueSwatch,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.insidersColorsAppBackground,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.insidersColorsAppBackground,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        extendedPadding: EdgeInsets.all(29.0),
      ),

      scaffoldBackgroundColor: AppColors.insidersColorsAppBackground,

      textTheme: const TextTheme(
        headline4: TextStyle(color: Colors.white),
      ),
    );
  }

  /// Light theme used by the app
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black, // appbar text color
      ),
      brightness: Brightness.light,
      primaryColor: Colors.white,
      bottomAppBarColor: AppColors.primary,
      primaryColorDark: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
    );
  }
}
