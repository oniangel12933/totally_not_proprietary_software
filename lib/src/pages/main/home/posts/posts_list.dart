import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recase/recase.dart';
import 'package:insidersapp/src/pages/main/home/posts/bloc/posts_filter_bloc.dart';
import 'package:insidersapp/src/pages/main/home/posts/post_item.dart';
import 'package:insidersapp/src/repositories/user/models/posts/posts_feed_response.dart';
import 'package:insidersapp/src/repositories/user/user_repository.dart';
import 'package:insidersapp/src/shared/config/app_config.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';

import 'bloc/posts_filter_bloc.dart';
import 'bloc/posts_filter_state.dart';

/// this pull all new posts for the user and displays them in an endless list
class PostsList extends StatefulWidget {
  const PostsList({
    Key? key,
    required this.userRepository,
    required this.filters,
  }) : super(key: key);

  final UserRepository userRepository;
  final List<String> filters;

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  static const _pageSize = 10;

  late ScrollController _scrollViewController;
  bool _showFiltersButton = true;
  bool isScrollingDown = false;

  late String _filterName;

  final PagingController<int, Item> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    _filterName = widget.filters.first;

    _pagingController.addPageRequestListener((pageKey) {
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
    _scrollViewController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollViewController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        isScrollingDown = true;
        _showFiltersButton = false;
        if (mounted) {
          setState(() {});
        }
      }
    }

    if (_scrollViewController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isScrollingDown) {
        isScrollingDown = false;
        _showFiltersButton = true;
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final PostsFeedResponse postsFeedResponse =
          await widget.userRepository.getPostsFeed(
        filter: _filterName.toLowerCase(),
        page: pageKey,
        size: _pageSize,
      );

      if (postsFeedResponse.items != null) {
        final isLastPage = postsFeedResponse.items!.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(postsFeedResponse.items!);
        } else {
          final int nextPageKey = pageKey + postsFeedResponse.items!.length;
          _pagingController.appendPage(postsFeedResponse.items!, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("show filter button $_showFiltersButton");
    const double filterButtonHeight = 25.0;

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
          return Column(
            children: [
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
                    child: AnimatedContainer(
                      height: _showFiltersButton ? filterButtonHeight : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: _getFilterButton(
                          context: context,
                          buttonHeight: filterButtonHeight,
                          onPressed: () {
                            _showPopupSheet(context);
                          }),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => _pagingController.refresh(),
                  ),
                  child: CustomScrollView(
                    // AlwaysScrollableScrollPhysics allows pull to refresh
                    // to work on an empty list
                    //physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollViewController,
                    slivers: <Widget>[
                      PagedSliverList<int, Item>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Item>(
                          noItemsFoundIndicatorBuilder: (context) => NoItemsFoundWidget(onTryAgain: () {
                            _pagingController.refresh();
                          }),
                            animateTransitions: true,
                            itemBuilder: (context, item, index) {
                              // if we start to use websockets for post,
                              // this will need to be moved into the bloc
                              String imageUrl =
                                  "${AppConfig().baseUrl}api/user/files/get_s3_image/${item.ownerAvatar?.id}";
                              //print("imageUrl: $imageUrl");
                              return UserPost(
                                postId: item.id ?? "",
                                imageUrl: imageUrl,
                                name: item.owner?.name ?? "",
                                username: "@${item.owner?.username}",
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
    _scrollViewController.removeListener(_scrollListener);
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
        //width: 107,
        height: buttonHeight,
      ),
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Row(
          children: [
            Text(
              _filterName.titleCase,
              style: Theme.of(context).textTheme.button,
            ),
            // using RichText instead of Icon so that the
            // icon will move when animated
            RichText(
              text: TextSpan(
                text: String.fromCharCode((iconData).codePoint),
                style: TextStyle(
                  inherit: false,
                  color: Colors.white,
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
    showPlatformModalSheet(
      context: context,
      cupertino: CupertinoModalSheetData(),
      builder: (_) => PlatformWidget(
        material: (_, __) => _androidPopupContent(context),
        cupertino: (_, __) => _cupertinoSheetContent(context),
      ),
    );
  }

  Widget _androidPopupContent(BuildContext context) {
    Widget _getAndroidItemContent(String filterName) {
      return GestureDetector(
        child: Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8),
          child: PlatformText(filterName),
        ),
        onTap: () {
          Navigator.pop(context, filterName.toLowerCase());
          context.read<PostsFilterBloc>().setFilter(filterName.toLowerCase());
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          for (String f in widget.filters) _getAndroidItemContent(f)
        ],
      ),
    );
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    Widget _getCupertinoItemContent(String filterName) {
      return CupertinoActionSheetAction(
        child: Text(filterName),
        onPressed: () {
          Navigator.pop(context, filterName.toLowerCase());
          context.read<PostsFilterBloc>().setFilter(filterName.toLowerCase());
        },
      );
    }

    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Theme.of(context).brightness,
      ),
      child: CupertinoActionSheet(
        title: const Text('Posts Filter'),
        message: const Text(
            'Please select the posts you would like to see from below'),
        actions: <Widget>[
          for (String f in widget.filters) _getCupertinoItemContent(f)
        ],
        // cancelButton: CupertinoActionSheetAction(
        //   child: const Text('Cancel'),
        //   isDefaultAction: true,
        //   onPressed: () {
        //     Navigator.pop(context, 'Cancel');
        //   },
        // ),
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
