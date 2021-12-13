import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:insidersapp/src/router/router.gr.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

class MainBottomNavModal extends StatelessWidget {
  const MainBottomNavModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (Theme.of(context).brightness == Brightness.dark)
          ? AppColors.involioFillFormBackgroundColor
          : AppColors.involioFillFormBackgroundColor,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 9),
                width: 45,
                height: 5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: AppColors.involioGreenGrayBlue,
                ),
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.account,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.account,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.settings,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.settings,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.router.push(const SettingsRoute());
              },
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
                title: Text(
                  AppLocalizations.of(context)!.notifications,
                  style: AppFonts.bodyBig
                      .copyWith(color: AppColors.involioWhiteShades80),
                ),
                leading: Icon(
                  context.involioIcons.bell,
                  color: AppColors.involioWhiteShades80,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  //context.router.push(const TestCupertinoRoute());
                }),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.myInterests,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.interests,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            /*ListTile( //TODO uncomment after MVP
              title: Text(
                AppLocalizations.of(context)!.myReviews,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.star,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),*/
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.drafts,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.drafts,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.giveFeedback,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.feedback,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.involioWalkthrough,
                style: AppFonts.bodyBig
                    .copyWith(color: AppColors.involioWhiteShades80),
              ),
              leading: Icon(
                context.involioIcons.walkThrough,
                color: AppColors.involioWhiteShades80,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(height: 1, color: AppColors.involioLineSeparator),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
