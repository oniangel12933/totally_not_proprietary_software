import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:insidersapp/src/pages/main/home/posts/post_details_view.dart';
import 'package:insidersapp/src/pages/main/home/posts/post_item.dart';

/// this pull all new posts for the user and displays them in an endless list
class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PostsState();
}

class PostsState extends State<Posts> {
  static int page = 0;
  final ScrollController _sc = ScrollController();
  bool isLoading = false;
  List<Map<String, dynamic>> users = [];
  final dio = Dio();

  @override
  void initState() {
    _getMoreData(page);
    super.initState();

    /// this listens for the user to scroll to the bottom of the page, then
    /// calls _getMoreData to get older posts
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ListView.builder(
      // Providing a restorationId allows the ListView to restore the
      // scroll position when a user leaves and returns to the app after it
      // has been killed while running in the background.
      restorationId: 'postItemListView',
      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          const String text =
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mattis quis praesent semper lacus, amet, aliquam ut quam.";

          Map<String, dynamic> user =  users[index];
          Map<String, dynamic> pics = user['picture'] as Map<String, dynamic>;
          String picUrl = pics['medium'] as String;
          Map<String, dynamic> loginInfo = user['login'] as Map<String, dynamic>;
          String name = "Sammi Jordan";
          String userName = loginInfo['username'] as String;

          // GestureDetector is used to detect if a user clicks on a post
          // and then navigates to the details for that post
          return GestureDetector(
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                    context, PostDetailsView.routeName);
              },
              child: UserPost(
                imageUrl: picUrl,
                name: name,
                username: "@" + userName,
                text: text,
                likes: "34",
                comments: "55",
                dollars: "55",
              ));
        }
      },
      controller: _sc,
    );
  }

  // makes a network call to see if there is more data.
  // setState is called to refresh the new data
  // randomuser.me is used to grab fake images and usernames
  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = "https://randomuser.me/api/?page=" +
          index.toString() +
          "&results=20&seed=abc";
      final response = await dio.get<Map<String, dynamic>>(url);
      Map<String, dynamic> responseData = response.data ?? <String, dynamic>{};

      List<dynamic> rList = <dynamic>[];
      if(responseData.containsKey('results')) {
        rList = responseData['results'] as List<dynamic>;
      }

      List<Map<String, dynamic>> uList = [];
      for (int i = 0; i < rList.length; i++) {
        uList.add(rList[i] as Map<String, dynamic>);
      }

      setState(() {
        isLoading = false;
        users.addAll(uList);
        page++;
      });
    }
  }

  // this is used to display a spinning circle at the bottom of the screen
  // while new data is being downloaded
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
