import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'bloc/post_like_bloc.dart';
import 'bloc/post_like_state.dart';

class OptimisticLikeButton extends StatefulWidget {
  const OptimisticLikeButton({
    Key? key,
    required this.iconSize,
    required this.fontSize,
    required this.postId,
    required this.totalLikeCount,
    required this.isLikedByUser,
    //required this.postLikeBloc,
  }) : super(key: key);

  //final PostLikeBloc postLikeBloc;
  final double iconSize;
  final double fontSize;
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
          /// this has a separate bloc so that is is not
          /// locked up when going is pressed
          /// or the other way around
          //if (bState.userToEvent != null) {

          // var p = const PostLikeState(isSavingLike: false, error: null, like: 1, likeCnt: 10, postId: "");
          // p.like;

          if (likedState.error != null) {}

          if (likedState.like != null) {
            // if (bState.userToEvent != null) {
            //   //UserToEventModel userToEvent = bState.userToEvent;
            //   //DFEventModel dfEvent = bState.dfEvent;
            //   widget.post.userToEvent.mUserToEventId =
            //       bState.userToEvent.objectId;
            // }
            // widget.post.dfEvent.mLikeCount = bState.likeCnt;
            // widget.post.userToEvent.mUserLike = bState.like;
          }

          return TextButton(
            //padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  likedState.like == true
                      ? context.involioIcons.heartFill
                      : context.involioIcons.heart,
                  color: likedState.like == true
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
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade600
                        : Colors.grey.shade500,
                    fontSize: widget.fontSize,
                  ),
                ),
              ],
            ),
            onPressed: () {
              // todo: like count number for different types of likes
              _postLikeBloc.likeButtonPressed(
                postId: widget.postId,
                //like: widget.post.isLike() ? UserToEventModel.LIKE_NO : UserToEventModel.LIKE_YES,
                likeWas: likedState.like,
                //likeCnt: widget.post.isLike()? widget.post.mLikeCount - 1 : widget.post.mLikeCount + 1,
                likeCntWas: likedState.likeCnt,
              );
            },
            /*
                                IconButton(
                                  icon: Icon(like
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  color: like
                                      ? Colors.red
                                      : Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey.shade600
                                          : Colors.grey.shade500,
                                  tooltip: 'Kudos',
                                  onPressed: () => null,
                                ),
                                */
          );
        });
  }
}
