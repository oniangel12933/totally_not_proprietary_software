import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:insidersapp/src/extensions/image_builder.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

import '../posts/like_button.dart';

class UserComment extends StatefulWidget {
  final String commentId;
  final String imageUrl;
  final String username;
  final String timestamp;
  final String text;
  final int likes;
  final bool liked;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserComment({
    Key? key,
    required this.commentId,
    required this.imageUrl,
    required this.username,
    required this.timestamp,
    required this.text,
    required this.likes,
    required this.liked,
  }) : super(key: key);

  @override
  State<UserComment> createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 58,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: UserComment.imageSize,
          child: ImageBuilder(
            url: widget.imageUrl,
            height: UserComment.imageSize,
            width: UserComment.imageSize,
            imageType: ImageType.profilePicture,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserNameAndPostTime(),
              const SizedBox(height: 6),
              Container(
                width: 213,
                child: _buildText(),
              ),
            ],
          ),
        ),
        Container(
          child: _buildButtons(),
        ),
      ]),
    );
  }

  Widget _buildUserNameAndPostTime() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        "${widget.username}  ·  ${widget.timestamp}",
        style: AppFonts.bodySmall.copyWith(
          color: AppColors.involioGreenGrayBlue,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        widget.text.length < 100
            ? widget.text
            : widget.text.substring(0, 100) + ' ...',
        //TODO add expanding elipsies button
        softWrap: true,
        style:
            AppFonts.comments1.copyWith(color: AppColors.involioWhiteShades60),
      ),
    );
  }

  Widget _buildButtons() {
    const double iconSize = 16.0;
    const double fontSize = 12.0;
    return OptimisticLikeButton(
      iconSize: iconSize,
      fontSize: fontSize,
      postId: widget.commentId,
      totalLikeCount: widget.likes,
      isLikedByUser: widget.liked,
      isVirticle: true,
    );
  }
}
