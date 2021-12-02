import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension InvolioIconsExt on BuildContext {
  /// Render either a Material or Cupertino icon based on the platform
  InvolioIcons get involioIcons => InvolioIcons(this);

  IconData involioIcon({
    required IconData material,
    required IconData cupertino,
  }) =>
      isMaterial(this) ? material : cupertino;
}

class InvolioIcons { // extends PlatformIcons {
  InvolioIcons(this.context); // : super(context);

  final BuildContext context;

  IconData get bell =>
      isMaterial(context) ? PhosphorIcons.bell : PhosphorIcons.bell;

  IconData get interests => isMaterial(context)
      ? PhosphorIcons.squaresFour
      : PhosphorIcons.squaresFour;

  IconData get feedback => isMaterial(context)
      ? PhosphorIcons.clipboardText
      : PhosphorIcons.clipboardText;

  IconData get walkThrough =>
      isMaterial(context) ? PhosphorIcons.bookOpen : PhosphorIcons.bookOpen;

  IconData get helpCenter =>
      isMaterial(context) ? PhosphorIcons.question : PhosphorIcons.question;

  IconData get drafts =>
      isMaterial(context) ? PhosphorIcons.fileDotted : PhosphorIcons.fileDotted;

  IconData get search =>
      isMaterial(context) ? PhosphorIcons.magnifyingGlass : PhosphorIcons.magnifyingGlass;

  IconData get searchFill =>
      isMaterial(context) ? PhosphorIcons.magnifyingGlassFill : PhosphorIcons.magnifyingGlassFill;

  IconData get home =>
      isMaterial(context) ? PhosphorIcons.house : PhosphorIcons.house;

  IconData get homeFill =>
      isMaterial(context) ? PhosphorIcons.houseFill : PhosphorIcons.houseFill;

  IconData get settings =>
      isMaterial(context) ? PhosphorIcons.sliders : PhosphorIcons.sliders;

  IconData get account =>
      isMaterial(context) ? PhosphorIcons.user : PhosphorIcons.user;

  IconData get accountFill =>
      isMaterial(context) ? PhosphorIcons.userFill : PhosphorIcons.userFill;

  IconData get info =>
      isMaterial(context) ? PhosphorIcons.info : PhosphorIcons.info;

  IconData get star =>
      isMaterial(context) ? PhosphorIcons.star : PhosphorIcons.star;

  IconData get menu =>
      isMaterial(context) ? PhosphorIcons.list : PhosphorIcons.list;

  IconData get plus =>
      isMaterial(context) ? PhosphorIcons.plus : PhosphorIcons.plus;

  IconData get chartLine =>
      isMaterial(context) ? PhosphorIcons.chartLine : PhosphorIcons.chartLine;

  IconData get chartLineFill =>
      isMaterial(context) ? PhosphorIcons.chartLineBold : PhosphorIcons.chartLineBold;

  IconData get heart =>
      isMaterial(context) ? PhosphorIcons.heart : PhosphorIcons.heart;

  IconData get heartFill =>
      isMaterial(context) ? PhosphorIcons.heartFill : PhosphorIcons.heartFill;

  IconData get messages =>
      isMaterial(context) ? PhosphorIcons.chatCircle : PhosphorIcons.chatCircle;

  IconData get comment =>
      isMaterial(context) ? PhosphorIcons.chatCircle : PhosphorIcons.chatCircle;

  IconData get commentFill =>
      isMaterial(context) ? PhosphorIcons.chatCircleFill : PhosphorIcons.chatCircleFill;

  IconData get dollarSign =>
      isMaterial(context) ? PhosphorIcons.currencyDollar : PhosphorIcons.currencyDollar;

  IconData get dollarSignFill =>
      isMaterial(context) ? PhosphorIcons.currencyDollarFill : PhosphorIcons.currencyDollarFill;

  IconData get share =>
      isMaterial(context) ? PhosphorIcons.share : PhosphorIcons.share;

  IconData get shareFill =>
      isMaterial(context) ? PhosphorIcons.shareFill : PhosphorIcons.shareFill;

  IconData get dotsThree =>
      isMaterial(context) ? PhosphorIcons.dotsThree : PhosphorIcons.dotsThree;

  IconData get dropDown =>
      isMaterial(context) ? PhosphorIcons.caretDown : PhosphorIcons.caretDown;

  IconData get followUser =>
      isMaterial(context) ? PhosphorIcons.userPlus : PhosphorIcons.userPlus;
}

