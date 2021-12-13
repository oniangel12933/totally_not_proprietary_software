import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageBuilder extends StatelessWidget {
  String url;
  double height;
  double width;
  ImageType? imageType;

  ImageBuilder(
      {required this.url,
      required this.height,
      required this.width,
      this.imageType = ImageType.profilePicture});

  @override
  Widget build(BuildContext context) {
    Widget image;
    switch (imageType) {
      case ImageType.profilePicture:
        image = _profilePicture(this);
        break;
      default:
        image = _profilePicture(this);
    }
    return image;
  }
}

Widget _profilePicture(ImageBuilder image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(3.0),
    child: CachedNetworkImage(
      imageUrl: image.url,
      height: image.height,
      width: image.width,
    ),
  );
}

enum ImageType {
  profilePicture,
}
