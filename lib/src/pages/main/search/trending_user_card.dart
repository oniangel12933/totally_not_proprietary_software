import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/shared/config/app_config.dart';
import 'package:insidersapp/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';
import 'package:numeral/numeral.dart';

class UserCard extends StatelessWidget {
  final AppApiTrendingSchemaUser user;
  final int index;

  const UserCard({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFollowing = user.following!;
    String _followButtonText = isFollowing
        ? AppLocalizations.of(context)!.following
        : AppLocalizations.of(context)!.follow;

    String imageUrl =
        "${AppConfig().baseUrl}api/user/files/get_s3_image/${user.ownerAvatar}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 18),
          child: Text("${index + 1}."),
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: AppImageBuilder(
            imageUrl: imageUrl,
            height: 56,
            width: 56,
            radius: 7.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(user.name!,
                  style: AppFonts.headline7.copyWith(
                    color: AppColors.involioWhiteShades100,
                  )),
            ),
            SizedBox(
              height: 19.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Numeral(user.followers!).value(fractionDigits: 1),
                      style: AppFonts.numbers1.copyWith(
                        color: AppColors.involioWhiteShades80,
                      )),
                  const SizedBox(width: 4),
                  Text(AppLocalizations.of(context)!.followers,
                      style: AppFonts.numbers1.copyWith(
                        color: AppColors.involioGreenGrayBlue,
                      )),
                  const SizedBox(width: 4),
                  Text("•",
                      style: AppFonts.numbers1.copyWith(
                        color: AppColors.involioWhiteShades80,
                      )),
                  const SizedBox(width: 4),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => isFollowing = !isFollowing,
                    child: Text(_followButtonText,
                        style: AppFonts.numbers1.copyWith(
                          color: AppColors.involioWhiteShades80,
                        )),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
