import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

import 'like_button.dart';

class UserComment extends StatefulWidget {
  final String? commentId;
  final String? ownerAvatar;
  final String? username;
  final DateTime? timestamp;
  final String? content;
  final int? likes;
  final bool? liked;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserComment({
    Key? key,
    required this.commentId,
    required this.ownerAvatar,
    required this.username,
    required this.timestamp,
    required this.content,
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
    String imageUrl =
        "${AppConfig().baseUrl}api/user/files/get_s3_image/${widget.ownerAvatar}";

    return Container(
      padding: const EdgeInsets.only(left: 38, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: UserComment.imageSize,
            child: AppImageBuilder(
              imageUrl: imageUrl,
              height: UserComment.imageSize,
              width: UserComment.imageSize,
              radius: 7,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            child: SizedBox(
              width: 270,
              child: Column(
                children: [
                  _buildUserNameAndPostTime(),
                  const SizedBox(height: 6),
                  _buildText(),
                ],
              ),
            ),
          ),
          OptimisticCommentLikeButton(
            iconSize: 16,
            fontSize: 12,
            commentId: widget.commentId!,
            totalLikeCount: widget.likes!,
            isLikedByUser: widget.liked!,
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameAndPostTime() {
    final String _timeStamp = widget.timestamp != null
        ? DateFormat('h:mm a').format(widget.timestamp as DateTime)
        : '';

    final String _username = widget.username ?? "";

    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        "@${_username.length <= 25 ? _username : _username.substring(0, 25)}  ·  $_timeStamp",
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
        widget.content ?? "",
        softWrap: true,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.comments1.copyWith(
          color: AppColors.involioWhiteShades60,
        ),
      ),
    );
  }
}
