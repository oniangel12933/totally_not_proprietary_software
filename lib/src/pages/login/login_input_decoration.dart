import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/theme/colors.dart';

InputDecoration getLoginInputDecoration({
  required String labelText,
  required String errorText,
  required FormzInput field,
  String? prefix,
  String? hintText,
}) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: field.valid
        ? const Icon(Icons.check, color: AppColors.insidersColorsCheckMarks)
        : null,
    prefix: prefix != null ? Text(prefix) : null,
    errorText: field.invalid ? errorText : null,
    fillColor: AppColors.insidersColorsAppBackgroundSwatch[400],
    hintStyle:
        TextStyle(color: AppColors.insidersColorsAppBackgroundSwatch[100]),
    hintText: hintText,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: AppColors.insidersColorsInsidersBlue, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    labelStyle: const TextStyle(
      color: Colors.white,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 20,
    ),
  );
}
