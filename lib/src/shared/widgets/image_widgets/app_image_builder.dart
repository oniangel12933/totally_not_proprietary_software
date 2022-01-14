import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';
import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/shared/config/app_config.dart';

class AppProfileImageBuilder extends StatelessWidget {
  late final String? pictureS3Id;
  final AppImageSize size;

  AppProfileImageBuilder({
    Key? key,
    this.pictureS3Id,
    required this.size,
  }) : super(key: key);

  Future<void> _setPictureS3IdToCurrentUser() async {
    UserBaseResponse user = await GetIt.I.get<UserRepository>().getUser();
    pictureS3Id = user.profile?.pictureS3Id;
  }

  @override
  Widget build(BuildContext context) {

    double imageSize;
    switch(size){
      case AppImageSize.small:
        imageSize = 45;
        break;
      case AppImageSize.medium:
        imageSize = 56;
        break;
      case AppImageSize.large:
        imageSize = 65;
        break;
      default:
        imageSize = 45;
    }

    if (pictureS3Id == null) {
      _setPictureS3IdToCurrentUser();
    }

    return AppImageBuilder(
      pictureS3Id: /*pictureS3Id ??*/ "e92d27e8-7d91-43ea-ad3b-ce12f6004e9c", //ToDo find default profile image
      height: imageSize,
      width: imageSize,
      radius: 7,
    );
  }
}

class AppImageBuilder extends StatelessWidget {
  final String pictureS3Id;
  final double height;
  final double width;
  final double radius;

  AppImageBuilder({
    Key? key,
    required this.pictureS3Id,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "${GetIt.I.get<AppConfig>().baseUrl}api/user/files/get_s3_image/$pictureS3Id";

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

enum AppImageSize{
  small,
  medium,
  large
}