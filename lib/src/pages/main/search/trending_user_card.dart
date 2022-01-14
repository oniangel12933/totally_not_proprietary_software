import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'follow_button.dart';

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
            child: AppProfileImageBuilder(
              pictureS3Id: user.ownerAvatar,
              size: AppImageSize.medium,
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(user.name ?? "",
                  style: AppFonts.headline7.copyWith(
                    color: AppColors.involioWhiteShades100,
                  )),
            ),
            OptimisticFollowButton(
              userId: user.id,
              isFollowing: user.following,
              followers: user.followers,
            )
          ],
        )
      ],
    );
  }
}
