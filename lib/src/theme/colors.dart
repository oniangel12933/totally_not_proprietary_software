import 'package:flutter/material.dart';

import 'package:insidersapp/src/extensions/swatch_gen.dart';

/// Used to contain custom colors that are used by the app
class AppColors {


  static const insidersColorsDeepBlue = Color(0xff0e225d);

  static const insidersColorsDarkBlue = Color(0xff244fd8);

  static const insidersColorsVibrantBlue = Color(0xff00cbf8);

  static const insidersColorsUiSelectionBoxes = Color(0xff2c2c2e);

  static const insidersColorsAssistiveErrorRed = Color(0xffff3737);

  static const insidersColorsAssistiveSuccessGreen = Color(0xff3fdb4f);

  static const insidersColorsInsidersBlueInt = 0xff085fe1;
  static const insidersColorsInsidersBlue = Color(0xff085fe1);
  static MaterialColor insidersColorsInsidersBlueSwatch = AppColors.insidersColorsInsidersBlue.genSwatch;

  static const insidersColorsAppBackgroundInt = 0xff1f2025;
  static const insidersColorsAppBackground = Color(0xff1f2025);
  static MaterialColor insidersColorsAppBackgroundSwatch = AppColors.insidersColorsAppBackground.genSwatch;

  // static const insidersBlack60 = Color(0xff575757);
  // static const insidersBlack40 = Color(0xff838383);
  // static const insidersBlack20 = Color(0xffaeaeae);
  // static const insidersBlack10 = Color(0xffc4c4c4);
  // static const insidersBlack5 = Color(0xffcfcfcf);
  // static const insidersBlack80 = Color(0xff2c2c2c);
  // static const insidersBlack100 = Color(0xff000000);
  // static const insidersWhite100 = Color(0xffffffff);

  //static const MaterialColor primarySwatch = Colors.grey;
  //static const int primaryInt = 0xff1f2025;
  static const Color primary = insidersColorsInsidersBlue; // #1F2025 1F2025FF // insidersColorsAppBackground
  static const Color accent = insidersColorsInsidersBlue;
  static const Color primaryLight = Color(0xFFFFFFFF);
  static const Color gradientLight = Color(0xFF2D383E);
  static const Color iconColor = Colors.grey;

  static const insidersColorsCheckMarks = insidersColorsAssistiveSuccessGreen;

  AppColors._();
}