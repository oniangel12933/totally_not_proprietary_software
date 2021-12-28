import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:involio/src/pages/main/home/posts/posts_filter_popup.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:recase/recase.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/home/posts/bloc/posts_filter_bloc.dart';
import 'package:involio/src/pages/main/home/posts/post_item.dart';
import 'package:involio/src/repositories/api/posts/posts_repository.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/posts_filter_bloc.dart';
import 'bloc/posts_filter_state.dart';

/// this pull all new posts for the user and displays them in an endless list
class PostsList extends StatefulWidget {
  const PostsList({
    Key? key,
    required this.filters,
  }) : super(key: key);

  final List<String> filters;

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  static const _pageSize = 20;

  final getIt = GetIt.instance;
  late ScrollController _scrollViewController;

  late String _filterName;

  final PagingController<int, AppApiFeedSchemaPost> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _filterName = widget.filters.first;

    _pagingController.addPageRequestListener((pageKey) {
      print("_pagingController.addPageRequestListener pageKey=$pageKey");
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching your feed.',
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
      final PostFeedResponse postsFeedResponse =
          await getIt.get<PostsRepository>().getPostsFeed(
                filter: _filterName.toLowerCase(),
                page: pageKey,
                size: _pageSize,
              );

      if (postsFeedResponse.items != null) {
        print("${postsFeedResponse.items!.length} < $_pageSize");

        final isLastPage = postsFeedResponse.items!.length < _pageSize;

        if (isLastPage) {
          _pagingController.appendLastPage(postsFeedResponse.items!);
        } else {
          final int nextPageKey = pageKey + 1;
          _pagingController.appendPage(postsFeedResponse.items!, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double filterButtonHeight = 27.0;

    return BlocListener<PostsFilterBloc, PostsFilterState>(
      listenWhen: (previous, current) {
        return previous.filterName != current.filterName;
      },
      listener: (context, state) {
        _filterName = state.filterName;
        _pagingController.refresh();
      },
      child: BlocBuilder<PostsFilterBloc, PostsFilterState>(
        buildWhen: (previous, current) =>
            previous.filterName != current.filterName,
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topLeft,
            children: [
              RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
                ),
                child: CustomScrollView(
                  /// AlwaysScrollableScrollPhysics allows pull to refresh
                  /// to work on an empty list
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollViewController,
                  slivers: <Widget>[
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    PagedSliverList<int, AppApiFeedSchemaPost>(
                      pagingController: _pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<AppApiFeedSchemaPost>(
                              noItemsFoundIndicatorBuilder: (context) =>
                                  NoItemsFoundWidget(onTryAgain: () {
                                    _pagingController.refresh();
                                  }),
                              animateTransitions: true,
                              itemBuilder: (context, item, index) {
                                // if we start to use websockets for post,
                                // this will need to be moved into the bloc
                                String imageUrl =
                                    "${AppConfig().baseUrl}api/user/files/get_s3_image/${item.ownerAvatar?.pictureS3Id}";
                                return UserPost(
                                  postId: item.id ?? "",
                                  imageUrl: imageUrl,
                                  name: item.owner?.name ?? "",
                                  username: "@${item.owner?.username}",
                                  //TODO in future should show days ago/weeks ago/etc if longer than a day.
                                  timestamp: item.timestamp != null
                                      ? DateFormat('h:mm a')
                                          .format(item.timestamp as DateTime)
                                      : '',
                                  text: item.content ?? "",
                                  likes: item.postLikes ?? 0,
                                  liked: item.liked ?? false,
                                  comments: "${item.postComments}",
                                  dollars: "${item.tips}",
                                );
                              }),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      right: AppThemes.edgePadding,
                      left: AppThemes.edgePadding,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: _getFilterButton(
                        context: context,
                        buttonHeight: filterButtonHeight,
                        onPressed: () {
                          _showPopupSheet(context);
                        }),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  Widget _getFilterButton({
    required BuildContext context,
    required final double buttonHeight,
    required VoidCallback? onPressed,
  }) {
    IconData iconData = context.involioIcons.dropDown;
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: buttonHeight,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 8, right: 8),
          primary: AppColors.involioBlue,
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _filterName.titleCase,
              style: AppFonts.headline7
                  .copyWith(color: AppColors.involioWhiteShades80),
            ),
            const SizedBox(width: 8),
            // using RichText instead of Icon so that the
            // icon will move when animated
            RichText(
              text: TextSpan(
                text: String.fromCharCode((iconData).codePoint),
                style: TextStyle(
                  inherit: false,
                  color: AppColors.involioWhiteShades80,
                  fontSize: 16,
                  fontFamily: (iconData).fontFamily,
                  package: (iconData).fontPackage,
                ),
              ),
            ), //Icon(Icons.add, size: 16.0),
          ],
        ),
      ),
    );
  }

  void _showPopupSheet(BuildContext context) async {
    isMaterial(context)
        ? showMaterialModalBottomSheet(
            expand: false,
            context: context,
            barrierColor: Colors.black.withOpacity(0.5),
            //backgroundColor: Colors.transparent,
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<PostsFilterBloc>(context),
              child: const PostsFilterModal(),
            ),
          )
        : showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            //backgroundColor: Colors.green,
            //backgroundColor: Colors.transparent,
            barrierColor: Colors.black.withOpacity(0.5),
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<PostsFilterBloc>(context),
              child: const PostsFilterModal(),
            ),
          );
  }
}

class NoItemsFoundWidget extends StatelessWidget {
  const NoItemsFoundWidget({Key? key, this.onTryAgain}) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ListItemsException(
        title: 'No posts found',
        //message: 'This list is currently empty.',
        onTryAgain: onTryAgain,
      );
}

class ListItemsException extends StatelessWidget {
  const ListItemsException({
    required this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (message != null)
              const SizedBox(
                height: 16,
              ),
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            if (onTryAgain != null)
              const SizedBox(
                height: 48,
              ),
            if (onTryAgain != null)
              SizedBox(
                height: 30,
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: onTryAgain,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
