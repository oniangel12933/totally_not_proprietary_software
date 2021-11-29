import 'package:flutter/material.dart';
import 'package:insidersapp/src/pages/main/home/posts/posts_view.dart';
import 'package:insidersapp/src/theme/colors.dart';

/// this builds a widget that displays tabs on the homepage above the posts
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            TabBar(
              unselectedLabelColor:
                  AppColors.involioGreenGrayBlue,
              labelColor: AppColors.involioBlue,
              indicatorColor: AppColors.involioBlue,
              tabs: [
                Tab(
                  child: Text(
                    'Posts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Drops',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostsView(),
                  Center(child: Text('Drops Tab')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
