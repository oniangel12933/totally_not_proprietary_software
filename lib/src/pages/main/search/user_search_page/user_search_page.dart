import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/search/user_search_page/user_search_card.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import '../search_input_decoration.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 8,
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(context.involioIcons.backButtonArrow),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                height: 36,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: TextField(
                  autofocus: true,
                  controller: searchTextController,
                  key: const Key('discover_search_page_input_textField'),
                  decoration: getSearchInputDecoration(
                    labelText: '',
                    prefixIcon: Icon(
                      context.involioIcons.search,
                      size: 20.0,
                    ),
                    context: context,
                    hintText: AppLocalizations.of(context)!.search,
                    errorText: '',
                  ),
                  style: AppFonts.body,
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppThemes.edgePadding),
        child: UserSearchResultsList(),
      ),
    );
  }
}

class UserSearchResultsList extends StatefulWidget {
  const UserSearchResultsList({Key? key}) : super(key: key);

  @override
  _UserSearchResultsListState createState() => _UserSearchResultsListState();
}

class _UserSearchResultsListState extends State<UserSearchResultsList> {
  final AppApiTrendingSchemaUser user = AppApiTrendingSchemaUser(
      id: "234",
      followers: 10,
      following: true,
      name: "Trader Jack",
      ownerAvatar: "e92d27e8-7d91-43ea-ad3b-ce12f6004e9c",
      username: "jack");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ListView(
        //padding: const EdgeInsets.all(8),
        children: <Widget>[
          UserSearchCard(user: user),
        ],
      ),
    );
  }
}
