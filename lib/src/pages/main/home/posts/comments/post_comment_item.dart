import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'post_comment_like_button.dart';

class UserPostComment extends StatefulWidget {
  final String? commentId;
  final String? ownerAvatar;
  final String? username;
  final DateTime? timestamp;
  final String? content;
  final int? likes;
  final bool? liked;
  static const double edge = AppThemes.edgePadding;
  static const double imageSize = 45.0;

  const UserPostComment({
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
  State<UserPostComment> createState() => _UserPostCommentState();
}

class _UserPostCommentState extends State<UserPostComment> {
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
        "${GetIt.I.get<AppConfig>().baseUrl}api/user/files/get_s3_image/${widget.ownerAvatar}";

    return Container(
      padding: const EdgeInsets.only(left: 38, right: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: UserPostComment.imageSize,
            child: AppImageBuilder(
              imageUrl: imageUrl,
              height: UserPostComment.imageSize,
              width: UserPostComment.imageSize,
              radius: 7,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                _buildUserNameAndPostTime(),
                const SizedBox(height: 6),
                _buildText(),
              ],
            ),
          ),
          const SizedBox(width: 10),
          OptimisticPostCommentLikeButton(
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
