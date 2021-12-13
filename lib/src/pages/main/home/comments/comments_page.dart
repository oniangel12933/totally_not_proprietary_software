import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/extensions/image_builder.dart';
import 'package:insidersapp/src/pages/login/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:insidersapp/src/pages/main/home/posts/post_item.dart';
import 'package:insidersapp/src/pages/main/home/posts/posts_list.dart';
import 'package:insidersapp/src/shared/config/app_config.dart';
import 'package:insidersapp/src/shared/config/get_it_setup.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

import '../posts/post_item.dart';
import '../posts/posts_list.dart';
import 'comment_item.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late ScrollController _scrollViewController;
  final PagingController<int, AppApiFeedSchemaPost> _pagingController =
      PagingController(firstPageKey: 1);

  //************* DON'T KNOW WHAT THIS DOES***********************
  @override
  void initState() {
    super.initState();

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
    // _scrollViewController.addListener(_scrollListener);
  }

  //*************************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Comments',
              style: AppFonts.body
                  .copyWith(color: AppColors.involioWhiteShades80)),
          leading: IconButton(
            icon: Icon(context.involioIcons.backArrow),
            color: AppColors.involioWhiteShades80,
            onPressed: () => null, //TODO add functionality
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          UserPost(
            postId: "123",
            imageUrl: "123",
            name: "John Richardson",
            username: "@ jDickie",
            //TODO in future should show days ago/weeks ago/etc if longer than a day.
            timestamp: DateFormat('h:mm a').format(DateTime.now()),
            text: "Check out these sweet sweet investments",
            likes: 38,
            liked: true,
            comments: "7",
            dollars: "80",
          ),
          Expanded(
            child: Container(
              child: Column(children: [
                UserComment(
                  commentId: "12434",
                  imageUrl: "imageUrl",
                  username: "@ jakerowe",
                  timestamp: DateFormat('h:mm a').format(DateTime.now()),
                  text:
                      "I have even more to say about this post so here is all i have to say about that but also more more more more",
                  likes: 7,
                  liked: false,
                ),
                UserComment(
                  commentId: "12434",
                  imageUrl: "imageUrl",
                  username: "@ jakerowe",
                  timestamp: DateFormat('h:mm a').format(DateTime.now()),
                  text: "this is pretty cool man",
                  likes: 7,
                  liked: false,
                ),
                UserComment(
                  commentId: "12434",
                  imageUrl: "imageUrl",
                  username: "@ jakerowe",
                  timestamp: DateFormat('h:mm a').format(DateTime.now()),
                  text: "this is pretty cool man",
                  likes: 7,
                  liked: false,
                ),
              ]),
            ),
            /*RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: CustomScrollView(
              // AlwaysScrollableScrollPhysics allows pull to refresh
              // to work on an empty list
              //physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollViewController,
              slivers: <Widget>[
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
                            // if we start to use websockets for comment,
                            // this will need to be moved into the bloc
                            String imageUrl =
                                "${AppConfig().baseUrl}api/user/files/get_s3_image/${item.ownerAvatar?.pictureS3Id}";
                            //print("imageUrl: $imageUrl");
                            return UserComment(
                              commentId: item.id ?? "",
                              imageUrl: imageUrl,
                              username: "@${item.owner?.username}",
                              //TODO in future should show days ago/weeks ago/etc if longer than a day.
                              timestamp: item.timestamp != null
                                  ? DateFormat('h:mm a')
                                      .format(item.timestamp as DateTime)
                                  : '',
                              text: item.content ?? "",
                              likes: item.postLikes ?? 0,
                              liked: item.liked ?? false,
                            );
                          }),
                ),
              ],
            ),
          ),*/
          ),
        ]),
        bottomNavigationBar: Container(
          color: AppColors.involioFillFormBackgroundColor,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 50),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              ImageBuilder(
                url: "some url",
                height: 45,
                width: 45,
                imageType: ImageType.profilePicture
              ),
              const SizedBox(width: 8),
              Container(
                width: 290,
                child: Row(children: [
                  Flexible(fit: FlexFit.tight, flex: 50, child: add_comment()),
                ]),
              )
            ]),
          ),
        ));
  }

  Widget add_comment() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: AppFonts.comments1.copyWith(color: AppColors.involioWhiteShades80),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.involioWhiteShades100),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.involioWhiteShades100),
        ),
        contentPadding: EdgeInsets.all(8),
        hintStyle:
            AppFonts.comments1.copyWith(color: AppColors.involioFillFormText),
        hintText: 'Add a comment as John Richardson',
      ),
    );
  }
}
