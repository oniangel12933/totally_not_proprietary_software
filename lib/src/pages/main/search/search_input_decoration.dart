import 'package:flutter/material.dart';

import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

InputDecoration getSearchInputDecoration({
  required String labelText,
  required String errorText,
  String? prefix,
  Icon? prefixIcon,
  String? hintText,
  required BuildContext context,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    labelText: labelText,
    prefix: prefix != null ? Text(prefix) : null,
    fillColor: AppColors.involioFillFormBackgroundColor,
    hintStyle: AppFonts.body.copyWith(color: AppColors.involioFillFormText),
    hintText: hintText,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    //floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(4.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.involioBlue, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    labelStyle: const TextStyle(
      color: Colors.white,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
  );
}
