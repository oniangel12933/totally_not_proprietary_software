import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:involio/src/router/router.gr.dart';

import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'post_like_button.dart';

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
  final String timestamp;
  final String text;
  final int likes;
  final bool liked;
  final int commentsCnt;
  final bool commentsEnabled;
  final String dollars;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserPost({
    Key? key,
    required this.postId,
    required this.imageUrl,
    required this.name,
    required this.username,
    required this.timestamp,
    required this.text,
    required this.likes,
    required this.liked,
    required this.commentsCnt,
    required this.commentsEnabled,
    required this.dollars,
  }) : super(key: key);

  @override
  State<UserPost> createState() => UserPostState();
}

class UserPostState extends State<UserPost> {
  late int currentCommentCnt = widget.commentsCnt;

  void incrementCommentCount() {
    setState(() {
      currentCommentCnt += 1;
    });
  }

  void decrementCommentCount() {
    setState(() {
      currentCommentCnt -= 1;
    });
  }

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
          padding:
              const EdgeInsets.only(left: UserPost.edge, right: UserPost.edge),
          child: Column(
            children: [
              SizedBox(
                height: UserPost.imageSize,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    const SizedBox(
                      width: 8.0,
                    ),
                    _buildHeaderText(context)
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildText()),
              Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _buildButtons(context)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child:
              const Divider(height: 1, color: AppColors.involioLineSeparator),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: widget.imageUrl,
        height: UserPost.imageSize,
        width: UserPost.imageSize,
      ),
    );
  }

  Widget _buildEllipsisButton(BuildContext context) {
    return Icon(
      context.involioIcons.dotsThree,
      color: AppColors.involioGreenGrayBlue,
    );
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
              _buildUserNameAndPostTime(),
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
          style: AppFonts.headline7.copyWith(
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildUserNameAndPostTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.username.length <= 25
              ? widget.username
              : widget.username.substring(0, 25),
          style: AppFonts.bodySmall.copyWith(
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
        Text("  ·  ${widget.timestamp}",
            style: AppFonts.bodySmall.copyWith(
              color: AppColors.involioGreenGrayBlue,
            )),
      ],
    );
  }

  Widget _buildText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        widget.text,
        softWrap: true,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.comments1.copyWith(
          color: AppColors.involioWhiteShades60,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    const double iconSize = 16.0;

    return Container(
      margin: const EdgeInsets.only(right: 32, left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //_buildIconButton(context.involioIcons.heart, widget.likes),
          OptimisticPostLikeButton(
            iconSize: iconSize,
            textStyle: AppFonts.comments1
                .copyWith(color: AppColors.involioGreenGrayBlue),
            postId: widget.postId,
            totalLikeCount: widget.likes,
            isLikedByUser: widget.liked,
          ),
          TextButton(
            child: _buildIconButton(
                context.involioIcons.comment, "$currentCommentCnt"),
            onPressed: () {
              if (widget.commentsEnabled) {
                final userPostKey = GlobalKey<UserPostState>();
                context.router.push(
                  CommentsRoute(
                    userPost: UserPost(
                      key: userPostKey,
                      postId: widget.postId,
                      imageUrl: widget.imageUrl,
                      name: widget.name,
                      username: widget.username,
                      timestamp: widget.timestamp,
                      text: widget.text,
                      likes: widget.likes,
                      liked: widget.liked,
                      commentsCnt: currentCommentCnt,
                      commentsEnabled: false,
                      dollars: widget.dollars,
                    ),
                  ),
                );
              }
            },
          ),

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
        const SizedBox(
          width: 8.0,
        ),
        Text(
          text,
          style: AppFonts.comments1.copyWith(
            color: AppColors.involioGreenGrayBlue,
          ),
        ),
      ],
    );
  }
}
