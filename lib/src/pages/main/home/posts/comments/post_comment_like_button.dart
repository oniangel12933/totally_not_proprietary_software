import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/post_comment_like_bloc.dart';
import 'bloc/post_comment_like_state.dart';

class OptimisticPostCommentLikeButton extends StatefulWidget {
  const OptimisticPostCommentLikeButton({
    Key? key,
    required this.iconSize,
    required this.fontSize,
    required this.commentId,
    required this.totalLikeCount,
    required this.isLikedByUser,
  }) : super(key: key);

  final double iconSize;
  final double fontSize;
  final String commentId;
  final int totalLikeCount;
  final bool isLikedByUser;

  @override
  State<OptimisticPostCommentLikeButton> createState() =>
      _OptimisticPostCommentLikeButtonState();
}

class _OptimisticPostCommentLikeButtonState
    extends State<OptimisticPostCommentLikeButton> {
  late final PostCommentLikeBloc _commentLikeBloc;

  @override
  void initState() {
    _commentLikeBloc = PostCommentLikeBloc(
      commentId: widget.commentId,
      likedCount: widget.totalLikeCount,
      liked: widget.isLikedByUser,
    );

    super.initState();
  }

  @override
  void dispose() {
    _commentLikeBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCommentLikeBloc, PostCommentLikeState>(
        bloc: _commentLikeBloc,
        builder: (BuildContext context, PostCommentLikeState likedState) {
          if (likedState.error != null) {}

          return TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 0),
              padding: const EdgeInsets.only(left: 8, right: 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  likedState.isLiked == true
                      ? context.involioIcons.heartFill
                      : context.involioIcons.heartBold,
                  color: likedState.isLiked == true
                      ? AppColors.involioAssistiveAndAlertHeart
                      : AppColors.involioGreenGrayBlue,
                  size: widget.iconSize,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text('${likedState.likeCnt}',
                    style: AppFonts.comments1.copyWith(
                      color: AppColors.involioGreenGrayBlue,
                    )),
              ],
            ),
            onPressed: () {
              _commentLikeBloc.likeButtonPressed(
                commentId: widget.commentId,
                likeWas: likedState.isLiked,
                likeCntWas: likedState.likeCnt,
              );
            },
          );
        });
  }
}
