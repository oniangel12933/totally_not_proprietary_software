import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:involio/src/extensions/text_style_extentions.dart';
import 'colors.dart';

/// ...where "light" is `FontWeight.w300`, "regular" is `FontWeight.w400` and
/// "medium" is `FontWeight.w500`.

/// The 2018 spec has thirteen text styles:
/// ```
/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5

class AppFonts {
  static FontWeight fontWeightLight = FontWeight.w300;
  static FontWeight fontWeightRegular = FontWeight.w400;
  static FontWeight fontWeightMedium = FontWeight.w500;
  static FontWeight fontWeightBold = FontWeight.bold;

  static TextStyle headline1 = GoogleFonts.rubik(
    fontSize: 32.44,
    fontWeight: fontWeightBold,
    letterSpacing: 0.4,
    //height: 41.0 / 32.44,
  );
  static StrutStyle headline1StrutStyle = headline1.strutStyleByHeight(41.0);

  static TextStyle headline2 = GoogleFonts.rubik(
    fontSize: 28.83,
    fontWeight: fontWeightMedium,
    letterSpacing: 0.2,
    //height: 43.0 / 28.83,
  );
  static StrutStyle headline2StrutStyle = headline2.strutStyleByHeight(43.0);

  static TextStyle headline3 = GoogleFonts.rubik(
    fontSize: 25.63,
    fontWeight: fontWeightMedium,
    letterSpacing: 1.2,
    //height: 33.0 / 25.63,
  );
  static StrutStyle headline3StrutStyle = headline3.strutStyleByHeight(33.0);

  static TextStyle headline4 = GoogleFonts.rubik(
    fontSize: 22.78,
    fontWeight: fontWeightMedium,
    letterSpacing: 1.0,
    //height: 41 / 22.78,
  );
  static StrutStyle headline4StrutStyle = headline4.strutStyleByHeight(41.0);

  static TextStyle headline5 = GoogleFonts.rubik(
    fontSize: 20.25,
    fontWeight: fontWeightMedium,
    letterSpacing: 1.2,
    //height: 30.0 / 20.25,
  );
  static TextStyle headline6 = GoogleFonts.rubik(
    fontSize: 18.0,
    fontWeight: fontWeightMedium,
    letterSpacing: 0.4,
    //height: 27 / 18.0,
  );
  static StrutStyle headline6StrutStyle = headline6.strutStyleByHeight(27.0);

  static TextStyle headline7 = GoogleFonts.rubik(
    fontSize: 16.0,
    fontWeight: fontWeightMedium,
    letterSpacing: 0.8,
    //height: 6.0 / 16.0,
  );
  static StrutStyle headline7StrutStyle = headline7.strutStyleByHeight(6.0);

  static TextStyle headline8 = GoogleFonts.rubik(
    fontSize: 14.0,
    fontWeight: fontWeightMedium,
    letterSpacing: 0.8,
  );

  static TextStyle bodySmall = GoogleFonts.rubik(
    fontSize: 14.0,
    fontWeight: fontWeightRegular,
    letterSpacing: -0.4,
    //height: 19.0 / 14.0,
  );
  static StrutStyle bodySmallStrutStyle = bodySmall.strutStyleByHeight(19.0);

  static TextStyle body = GoogleFonts.rubik(
    fontSize: 16.0,
    fontWeight: fontWeightRegular,
    letterSpacing: 0.8,
    //height: 24.0 / 16.0,
  );
  static StrutStyle bodyStrutStyle = body.strutStyleByHeight(24.0);

  static TextStyle bodyBig = GoogleFonts.rubik(
    fontSize: 18.0,
    fontWeight: fontWeightRegular,
    letterSpacing: 0.8,
    //height: 23.1 / 18.0,
  );
  static StrutStyle bodyBigStrutStyle = bodyBig.strutStyleByHeight(23.1);

  static TextStyle comments1 = GoogleFonts.hindSiliguri(
    fontSize: 16.0,
    fontWeight: fontWeightRegular,
    letterSpacing: 0.8,
    //height: 19.0 / 16.0,
  );
  static StrutStyle comments1StrutStyle = comments1.strutStyleByHeight(19.0);

  static TextStyle numbers1 = GoogleFonts.hindSiliguri(
    fontSize: 14.0,
    fontWeight: fontWeightRegular,
    letterSpacing: -0.4,
    //height: 19.0 / 14.0,
  );
  static StrutStyle numbers1StrutStyle = numbers1.strutStyleByHeight(19.0);

  static TextStyle notForFinancialAdvice = GoogleFonts.rubik(
    fontSize: 12.0,
    fontWeight: fontWeightRegular,
    letterSpacing: -0.4,
    //height: 12.0 / 12.0,
  );
  static StrutStyle notForFinancialAdviceStrutStyle =
      notForFinancialAdvice.strutStyleByHeight(12.0);

  /// This is setup for defaults, but this will not be used much.
  /// Use AppFonts instead
  static TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.rubik(
      fontSize: 32.44,
      fontWeight: fontWeightBold,
      letterSpacing: 0.4,
    ),
    headline2: GoogleFonts.rubik(
      fontSize: 28.83,
      fontWeight: fontWeightMedium,
      letterSpacing: 0.2,
    ),
    headline3: GoogleFonts.rubik(
      fontSize: 25.63,
      fontWeight: fontWeightMedium,
      letterSpacing: 1.2,
    ),
    headline4: GoogleFonts.rubik(
      fontSize: 22.78,
      fontWeight: fontWeightMedium,
      letterSpacing: 1.0,
    ),
    headline5: GoogleFonts.rubik(
      fontSize: 20.25,
      fontWeight: fontWeightMedium,
      letterSpacing: 1.2,
    ),
    headline6: GoogleFonts.rubik(
      fontSize: 18.0,
      fontWeight: fontWeightMedium,
      letterSpacing: 0.4,
    ),
    subtitle1: GoogleFonts.rubik(
      fontSize: 16.0,
      fontWeight: fontWeightMedium,
      letterSpacing: 0.8,
    ),
    subtitle2: GoogleFonts.rubik(
      fontSize: 14.0,
      fontWeight: fontWeightMedium,
      letterSpacing: 0.8,
    ),
    bodyText1: GoogleFonts.rubik(
      fontSize: 16.0,
      fontWeight: fontWeightRegular,
      letterSpacing: 0.8,
    ),
    bodyText2: GoogleFonts.rubik(
      fontSize: 14.0,
      fontWeight: fontWeightRegular,
      letterSpacing: -0.4,
    ),
    button: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: fontWeightMedium,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.rubik(
      fontSize: 12,
      fontWeight: fontWeightRegular,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.rubik(
      fontSize: 10,
      fontWeight: fontWeightRegular,
      letterSpacing: 1.5,
    ),
  );
}

/// Custom themes for the app
class AppThemes {
  static const cupertinoDarkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.involioBlue,
    barBackgroundColor: AppColors.involioBackground,
    scaffoldBackgroundColor: AppColors.involioBackground,
  );

  /// Dark theme used by the app
  static ThemeData get materialDarkTheme {
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.involioBackground,
      ),
      cupertinoOverrideTheme: cupertinoDarkTheme,
      // not sure if this is doing anything
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
      textTheme: AppFonts.textTheme,
    );
  }

  static const cupertinoLightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.involioBlue,
    barBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

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
      textTheme: AppFonts.textTheme,
    );
  }

  static const double edgePadding = 20;
}
