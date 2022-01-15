import 'package:flutter/material.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

class UserSearchCard extends StatelessWidget {
  final UserSearchResult user;

  const UserSearchCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 16),
          child: AppImageBuilder(
            pictureS3Id: user.ownerAvatar?.pictureS3Id ?? "",
            height: 48,
            width: 48,
            radius: 3.0,
          ),
        ),
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
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(user.username != null ? "@${user.username}" : "",
                  style: AppFonts.bodySmall.copyWith(
                    color: AppColors.involioWhiteShades100,
                  )),
            ),
          ],
        )
      ],
    );
  }
}
