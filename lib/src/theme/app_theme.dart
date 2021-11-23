import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Custom themes for the app
class AppThemes {

  static const double edgePadding = 20;

  static const cupertinoDarkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.involioBlue,
    barBackgroundColor: AppColors.involioBackground,
    scaffoldBackgroundColor: AppColors.involioBackground,
  );

  static const cupertinoLightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.involioBlue,
    barBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

  /// Dark theme used by the app
  static ThemeData get materialDarkTheme {
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.involioBackground,
      ),
      cupertinoOverrideTheme: cupertinoDarkTheme, // not sure if this is doing anything
      brightness: Brightness.dark,
      primaryColor: AppColors.involioBlue,
      primarySwatch: AppColors.involioBlueSwatch,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.involioBackground,
        elevation: 0.0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.involioBackground,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.involioBackground,
        selectedItemColor: AppColors.involioBlue,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        extendedPadding: EdgeInsets.all(29.0),
      ),
      scaffoldBackgroundColor: AppColors.involioBackground,
      // textTheme: const TextTheme(
      //   headline4: TextStyle(color: Colors.white),
      // ),
    );
  }

  /// Light theme used by the app
  static ThemeData get materialLightTheme {
    return ThemeData(
      cupertinoOverrideTheme: cupertinoLightTheme,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black, // appbar text color
      ),
      brightness: Brightness.light,
      primaryColor: Colors.white,
      bottomAppBarColor: AppColors.involioBackground,
      primaryColorDark: AppColors.involioBlue,
      primaryColorLight: AppColors.involioBlue,
    );
  }
}
