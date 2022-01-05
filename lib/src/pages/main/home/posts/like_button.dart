import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:involio/src/shared/icons/involio_icons.dart';
import 'bloc/post_like_bloc.dart';
import 'bloc/post_like_state.dart';

class OptimisticLikeButton extends StatefulWidget {
  const OptimisticLikeButton({
    Key? key,
    required this.iconSize,
    required this.textStyle,
    required this.postId,
    required this.totalLikeCount,
    required this.isLikedByUser,
    //required this.postLikeBloc,
  }) : super(key: key);

  final double iconSize;
  final TextStyle textStyle;
  final String postId;
  final int totalLikeCount;
  final bool isLikedByUser;

  @override
  State<OptimisticLikeButton> createState() => _OptimisticLikeButtonState();
}

class _OptimisticLikeButtonState extends State<OptimisticLikeButton> {
  late final PostLikeBloc _postLikeBloc;

  @override
  void initState() {
    _postLikeBloc = PostLikeBloc(
      postId: widget.postId,
      likedCount: widget.totalLikeCount,
      liked: widget.isLikedByUser,
    );

    super.initState();
  }

  @override
  void dispose() {
    _postLikeBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostLikeBloc, PostLikeState>(
        bloc: _postLikeBloc,
        builder: (BuildContext context, PostLikeState likedState) {
          if (likedState.error != null) {}

          return TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 0),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            //padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  likedState.isLiked == true
                      ? context.involioIcons.heartFill
                      : context.involioIcons.heartBold,
                  color: likedState.isLiked == true
                      ? Colors.red
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade600
                          : Colors.grey.shade500,
                  size: widget.iconSize,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  '${likedState.likeCnt}',
                  style: widget.textStyle,
                ),
              ],
            ),
            onPressed: () {
              _postLikeBloc.likeButtonPressed(
                postId: widget.postId,
                likeWas: likedState.isLiked,
                likeCntWas: likedState.likeCnt,
              );
            },
          );
        });
  }
}
