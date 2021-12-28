import 'package:flutter/material.dart';

import 'package:involio/src/extensions/swatch_gen.dart';

/// Used to contain custom colors that are used by the app
class AppColors {
  static late MaterialColor involioBlueSwatch = AppColors.involioBlue.genSwatch;
  static late MaterialColor involioBackgroundSwatch =
      AppColors.involioBackground.genSwatch;

  //static late Color involioDarkModeIconColor = involioBackgroundSwatch[100]!;

  static const involioLightBackground = Colors.white;

  static const involioBlue = Color(0xff1a67db);
  static const involioDarkBlue = Color(0xff0e225d);
  static const involioGreyBlue = Color(0xff2b5c95);
  static const involioBrightBlue = Color(0xff45a9e1);
  static const involioGreenGrayBlue = Color(0xffa2aeb3);

  static const involioUserNameColor = Color(0xffc9cacc);
  static const involioBackground = Color(0xff282c32);
  static const involioFillFormBackgroundColor = Color(0xff343840);
  static const involioFooter = Color(0xff1e1f24);
  static const involioFooterBackground = Color(0xff1e1f24);
  static const involioKeyPadButtons = Color(0xff242424);
  static final involioKeyPadBackground = const Color(0xff202020).withOpacity(.92);
  static final involioFillFormText = const Color(0xffebebf5).withOpacity(.60);
  static final involioLineSeparator = const Color(0xff797676).withOpacity(.30);
  static const involioInactive = Color(0xff959595);
  static final involioTabInactive = const Color(0xffcfd3d9).withOpacity(.50);
  static final involioPopUps = const Color(0xff1f2025).withOpacity(.79);

  static const involioReplyBoxTextReplyText = Color(0xff9ba6bb);
  static final involioReplyBoxTextOverlay = const Color(0xff000000).withOpacity(.25);
  static final involioReplyBoxTextUnfilledFillForm = const Color(0xffffffff).withOpacity(.30);

  static const involioAssistiveAndAlertHeart = Color(0xffD90707);
  static const involioAssistiveAndAlertRed = Color(0xffff3737);
  static const involioAssistiveAndAlertStarYellow = Color(0xfff6f97b);
  static const involioAssistiveAndAlertGreen = Color(0xff3fdb4f);

  static const involioPieChart4th = Color(0xff111d41);
  static const involioPieChart5th = Color(0xff1a3b62);
  static const involioPieChart6th = Color(0xff2b517e);
  static const involioPieChart7th = Color(0xff4772a5);
  static const involioPieChart8th = Color(0xffb7d8ff);
  static const involioPieChart9th = Color(0xffd0e6ff);

  static const involioBlackShades100 = Color(0xff000000);
  static const involioBlackShades80 = Color(0xff2c2c2c);
  static const involioBlackShades60 = Color(0xff575757);
  static const involioBlackShades40 = Color(0xff838383);
  static const involioBlackShades20 = Color(0xffaeaeae);
  static const involioBlackShades10 = Color(0xffc4c4c4);
  static const involioBlackShades5 = Color(0xffcfcfcf);

  static const involioWhiteShades100 = Color(0xffffffff);
  static const involioWhiteShades80 = Color(0xfff8f8f8);
  static const involioWhiteShades60 = Color(0xfff0f0f0);
  static const involioWhiteShades40 = Color(0xffe9e9e9);
  static const involioWhiteShades20 = Color(0xffe1e1e1);
  static const involioWhiteShades10 = Color(0xffdedede);
  static const involioWhiteShades5 = Color(0xffdcdcdc);

  AppColors._();
}
