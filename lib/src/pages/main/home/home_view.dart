import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/pages/main/home/posts/posts_view.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

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
          children: [
            TabBar(
              unselectedLabelColor: AppColors.involioTabInactive,
              labelColor: AppColors.involioBlue,
              indicatorColor: AppColors.involioBlue,
              tabs: [
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.posts,
                    style: AppFonts.headline5,
                  ),
                ),
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!.drops,
                    style: AppFonts.headline5,
                  ),
                ),
              ],
            ),
            //Divider(height: 1, color: AppColors.involioTabInactive), ToDo grey line under tab bar
            const Expanded(
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
