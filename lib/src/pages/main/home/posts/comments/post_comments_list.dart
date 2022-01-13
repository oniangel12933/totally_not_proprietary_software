import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/home/posts/comments/bloc/post_comment_bloc.dart';
import 'package:involio/src/repositories/api/comments/comments_repository.dart';
import 'post_comment_item.dart';

class PostCommentsList extends StatefulWidget {
  final String postId;

  const PostCommentsList({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  _PostCommentsListState createState() => _PostCommentsListState();
}

class _PostCommentsListState extends State<PostCommentsList> {
  static const _pageSize = 20;

  final getIt = GetIt.instance;
  late ScrollController _scrollViewController;
  final PagingController<int, Comment> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      print("_pagingController.addPageRequestListener pageKey=$pageKey");
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching comments.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    _scrollViewController = ScrollController();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final GetPostCommentsResponse getCommentResponse =
          await getIt.get<CommentsRepository>().getPostComments(
                postId: widget.postId,
                size: _pageSize,
                page: pageKey,
                sorting: "desc",
              );

      if (getCommentResponse.items != null) {
        print("${getCommentResponse.items!.length} < $_pageSize");

        final isLastPage = getCommentResponse.items!.length < _pageSize;

        if (isLastPage) {
          _pagingController.appendLastPage(getCommentResponse.items!);
        } else {
          final int nextPageKey = pageKey + 1;
          _pagingController.appendPage(getCommentResponse.items!, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCommentBloc, PostCommentState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is PostCommentPostedSuccessfullyState) {
          setState(() {
            if (_pagingController.itemList != null) {
              _pagingController.itemList?.insert(
                  0,
                  Comment(
                    id: "not a real id",
                    content: state.content,
                    timestamp: DateTime.now(),
                  ));
            }

            _scrollViewController.animateTo(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticInOut);
          });
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollViewController,
              slivers: <Widget>[
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                PagedSliverList<int, Comment>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Comment>(
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        return UserPostComment(
                          commentId: item.id,
                          username: item.owner?.username,
                          content: item.content,
                          ownerAvatar: item.ownerAvatar?.pictureS3Id,
                          timestamp: item.timestamp,
                          likes: 0,
                          liked: false,
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }
}
