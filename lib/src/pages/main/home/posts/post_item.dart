import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

import 'like_button.dart';

/// This is a single post item that will be displayed in a list of posts
///  imageUrl - The URL for where to get the image to display
///  user - Full name of the user
///  username - post username
///  text - post text
///  likes - number of likes for this post
///  comments - number of comments for this post
///  dollars - dollars for this post
class UserPost extends StatefulWidget {
  final String postId;
  final String imageUrl;
  final String name;
  final String username;
  final String text;
  final int likes;
  final bool liked;
  final String comments;
  final String dollars;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserPost({
    Key? key,
    required this.postId,
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.text,
    required this.likes,
    required this.liked,
    required this.comments,
    required this.dollars,
  }) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: UserPost.edge, right: UserPost.edge),
          child: Column(
            children: [
              SizedBox(
                height: UserPost.imageSize,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    const SizedBox(width: 8.0,),
                    _buildHeaderText(context)
                  ],
                ),
              ),
              const SizedBox(height: 8.0,),
              _buildText(),
              const SizedBox(height: 16.0,),
              _buildButtons(context),
              const SizedBox(height: 12.0,),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 0, bottom: 24, left: 0.0, right: 0.0),
          child: const Divider(
            height: 0,
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        height: UserPost.imageSize,
        width: UserPost.imageSize,
      ),
    );
  }

  Widget _buildEllipsisButton(BuildContext context) {
    return Icon(context.involioIcons.dotsThree);
  }

  Widget _buildHeaderText(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildName(),
              _buildUserNameAndPostTime()
            ],
          ),
          _buildEllipsisButton(context),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Row(
      children: [
        Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildUserNameAndPostTime() {
    return Row(
      children: [
        Text(
          "${widget.username} · 1h",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12.0,
            color: AppColors.involioUserNameColor,
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Text(
      widget.text,
      overflow: TextOverflow.clip,
      style: const TextStyle(),
    );
  }

  Widget _buildButtons(BuildContext context) {
    const double iconSize = 16.0;
    const double fontSize = 12.0;
    return Container(
      margin: const EdgeInsets.only(right: 32, left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //_buildIconButton(context.involioIcons.heart, widget.likes),
          OptimisticLikeButton(
            iconSize: iconSize,
            fontSize: fontSize,
            postId: widget.postId,
            totalLikeCount: widget.likes,
            isLikedByUser: widget.liked,
          ),
          _buildIconButton(context.involioIcons.comment, widget.comments),
          _buildIconButton(context.involioIcons.dollarSign, widget.dollars),
          _buildIconButton(context.involioIcons.share, ''),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: AppColors.involioGreenGrayBlue,
        ),
        const SizedBox(width: 8.0,),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.0,
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
      ],
    );
  }
}


