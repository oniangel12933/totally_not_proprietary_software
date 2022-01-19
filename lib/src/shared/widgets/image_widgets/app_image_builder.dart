import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/src/shared/blocs/user/cubit.dart';
import 'package:involio/src/shared/config/app_config.dart';

enum AppImageSize {
  small,
  medium,
  large,
  xlarge
}

class AppCurrentUserProfileImageBuilder extends StatefulWidget {
  final AppImageSize size;

  const AppCurrentUserProfileImageBuilder({Key? key, required this.size})
      : super(key: key);

  @override
  _AppCurrentUserProfileImageBuilderState createState() =>
      _AppCurrentUserProfileImageBuilderState();
}

class _AppCurrentUserProfileImageBuilderState
    extends State<AppCurrentUserProfileImageBuilder> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return AppProfileImageBuilder(
          pictureS3Id: state.user?.profile?.pictureS3Id,
          size: widget.size,
        );
      },
    );
  }
}

class AppProfileImageBuilder extends StatelessWidget {
  final String? pictureS3Id;
  final AppImageSize size;

  const AppProfileImageBuilder({
    Key? key,
    required this.pictureS3Id,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize;
    switch (size) {
      case AppImageSize.small:
        imageSize = 45;
        break;
      case AppImageSize.medium:
        imageSize = 56;
        break;
      case AppImageSize.large:
        imageSize = 65;
        break;
      case AppImageSize.xlarge:
        imageSize = 130;
        break;
      default:
        imageSize = 45;
    }

    return AppImageBuilder(
      pictureS3Id: /*pictureS3Id ??*/ "e92d27e8-7d91-43ea-ad3b-ce12f6004e9c",
      //ToDo find default profile image
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

  const AppImageBuilder({
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
