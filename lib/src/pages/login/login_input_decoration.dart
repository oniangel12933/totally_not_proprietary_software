import 'package:flutter/material.dart';

import 'package:formz/formz.dart';

import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

InputDecoration getLoginInputDecoration({
  required String labelText,
  required String errorText,
  required FormzInput field,
  String? prefix,
  Widget? prefixIcon,
  String? hintText,
}) {
  return InputDecoration(

    /// uncomment below to add checkmarks when a field is validated.
    // suffixIcon: field.valid
    //     ? const Icon(Icons.check, color: AppColors.involioAssistiveAndAlertGreen)
    //     : null,

    labelText: labelText,
    prefixIcon: prefixIcon,
    prefix: prefix != null ? Text(prefix) : null,
    errorText: field.invalid ? errorText : null,
    errorStyle: TextStyle(color: AppColors.involioAssistiveAndAlertHeart),
    fillColor: AppColors.involioFillFormBackgroundColor,
    hintStyle: AppFonts.bodyBig.copyWith(color: AppColors.involioWhiteShades100.withOpacity(.3)),
    hintText: hintText,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    //floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: AppColors.involioBlue, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    labelStyle: const TextStyle(
      color: Colors.white,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
  );
}
