import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AppImageBuilder extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;

  const AppImageBuilder({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
