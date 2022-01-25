import 'package:flutter/material.dart';
import 'package:involio/src/theme/colors.dart';

class SheetTopHandleWidget extends StatelessWidget {
  const SheetTopHandleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.15,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: const BoxDecoration(
            color: AppColors.involioGreenGrayBlue,
            borderRadius: BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
