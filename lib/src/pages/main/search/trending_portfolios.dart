import 'package:flutter/material.dart';
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
            Text(title, style: AppFonts.headline6),
            TextButton(
              style: TextButton.styleFrom(
                //minimumSize: Size.zero,
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "View Top 20",
                style: AppFonts.body,
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
  const TrendingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 73.0,
      decoration: BoxDecoration(
          color: AppColors.involioBackgroundSwatch[400]!,
          border: Border.all(
            color: AppColors.involioBackgroundSwatch[400]!,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("My First Portfolio Long Hold Stuffs",
              style: AppFonts.headline7),
          const SizedBox(width: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Cryptocurrency", style: AppFonts.numbers1),
              const SizedBox(width: 4),
              Text("•", style: AppFonts.numbers1),
              const SizedBox(width: 4),
              Text("256k", style: AppFonts.numbers1),
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
