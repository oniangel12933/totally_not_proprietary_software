import 'package:flutter/material.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

/// This is a single post item that will be displayed in a list of posts
///  imageUrl - The URL for where to get the image to display
///  user - Full name of the user
///  username - post username
///  text - post text
///  likes - number of likes for this post
///  comments - number of comments for this post
///  dollars - dollars for this post
class UserPost extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String username;
  final String text;
  final String likes;
  final String comments;
  final String dollars;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserPost({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.text,
    required this.likes,
    required this.comments,
    required this.dollars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: edge, right: edge),
          child: Column(
            children: [
              SizedBox(
                height: imageSize,
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
      child: Image.network(
        imageUrl,
        height: imageSize,
        width: imageSize,
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

  // builds the header for the post
  Widget _buildName() {
    return Row(
      children: [
        Text(
          name,
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
          "$username · 1h",
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12.0,
            color: AppColors.involioUserNameColor,
          ),
        ),
      ],
    );
  }

  // this is the main text for the post
  Widget _buildText() {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style: const TextStyle(),
    );
  }

  // build the buttons at the bottom of the post with counts
  Widget _buildButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 32, left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(context.involioIcons.heart, likes),
          _buildIconButton(context.involioIcons.comment, comments),
          _buildIconButton(context.involioIcons.dollarSign, dollars),
          _buildIconButton(context.involioIcons.share, ''),
        ],
      ),
    );
  }

  // helper to make building buttons at the bottom easier
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
