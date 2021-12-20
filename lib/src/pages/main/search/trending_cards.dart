import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numeral/numeral.dart';

import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

class TrendingCategory extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget child;

  const TrendingCategory({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style: AppFonts.headline6
                    .copyWith(color: AppColors.involioWhiteShades60)),
            TextButton(
              style: TextButton.styleFrom(
                //minimumSize: Size.zero,
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                AppLocalizations.of(context)!.viewTop20,
                style: AppFonts.body.copyWith(color: AppColors.involioBlue),
              ),
              onPressed: onPressed,
            ),
          ],
        ),
        child,
      ],
    );
  }
}

class TrendingCard extends StatelessWidget {
  final String title;
  final String investmentType;
  final int followerCount;

  const TrendingCard({
    Key? key,
    required this.title,
    required this.investmentType,
    required this.followerCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 73.0,
      decoration: BoxDecoration(
          color: AppColors.involioFillFormBackgroundColor,
          border: Border.all(
            color: AppColors.involioFillFormBackgroundColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(title, style: AppFonts.headline7)),
          const SizedBox(width: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(investmentType, style: AppFonts.numbers1),
              const SizedBox(width: 4),
              Text("•", style: AppFonts.numbers1),
              const SizedBox(width: 4),
              Text(Numeral(followerCount).value(fractionDigits: 1),
                  style: AppFonts.numbers1),
              const SizedBox(width: 4),
              Text("Followers",
                  style: AppFonts.numbers1.copyWith(
                    color: AppColors.involioGreenGrayBlue,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
