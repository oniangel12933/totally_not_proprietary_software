import 'package:flutter/material.dart';

/// Displays detailed information about a Post when a post is clicked.
class PostDetailsView extends StatelessWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  static const routeName = '/post_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: const Center(
        child: Text('More Info'),
      ),
    );
  }
}
