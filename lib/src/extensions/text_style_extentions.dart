import 'package:flutter/material.dart';

extension TextStyleResetHeightExtension on TextStyle {
  TextStyle get resetHeight {
    return copyWith(height: 1.0);
  }
}

extension TextStyleGetStrutByFigmaHeight on TextStyle {
  StrutStyle strutStyleByHeight(double height) {
    if(fontSize != null) {
      return StrutStyle(fontSize: fontSize, height: height / fontSize!);
    } else {
      return StrutStyle(fontSize: fontSize);
    }
  }
}
