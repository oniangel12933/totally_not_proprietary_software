import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:insidersapp/src/pages/main/search/trending_portfolios.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppThemes.edgePadding),
      child: _SearchInput(
        controller: searchTextController,
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final TextEditingController controller;

  const _SearchInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 36,
          child: TextField(
            controller: controller,
            key: const Key('discover_search_input_textField'),
            decoration: getSearchInputDecoration(
              labelText: '',
              prefixIcon: Icon(
                context.involioIcons.search,
                size: 20.0,
              ),
              context: context,
              hintText: "Search",
              errorText: '',
            ),
            style: AppFonts.body,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                TrendingCategory(
                  title: "Trending Portfolios",
                  onPressed: () {},
                  child: Column(
                    children: const [
                      TrendingCard(),
                      SizedBox(height: 16.0),
                      TrendingCard(),
                    ],
                  ),
                ),
                TrendingCategory(
                  title: "Trending Strategies",
                  onPressed: () {},
                  child: Column(
                    children: const [
                      TrendingCard(),
                      SizedBox(height: 16.0),
                      TrendingCard(),
                    ],
                  ),
                ),
                TrendingCategory(
                  title: "Trending Users",
                  onPressed: () {},
                  child: Column(
                    children: const [
                      UserImageList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UserImageList extends StatelessWidget {
  const UserImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(10.0),
      height: 114.0,
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
        itemBuilder: (_, i) => const TrendingUserCard(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class TrendingUserCard extends StatelessWidget {
  const TrendingUserCard({
    Key? key,
  }) : super(key: key);

  final imageUrl =
      "https://i.kym-cdn.com/photos/images/original/001/764/548/d82.jpg";
  final imageSize = 114.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: imageSize,
        //width: imageSize,
      ),
    );
  }
}

InputDecoration getSearchInputDecoration({
  required String labelText,
  required String errorText,
  String? prefix,
  Icon? prefixIcon,
  String? hintText,
  required BuildContext context,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    labelText: labelText,
    prefix: prefix != null ? Text(prefix) : null,
    fillColor: AppColors.involioBackgroundSwatch[400],
    hintStyle:
        AppFonts.body.copyWith(color: AppColors.involioBackgroundSwatch[100]),
    hintText: hintText,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    //floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(4.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.involioBlue, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    labelStyle: const TextStyle(
      color: Colors.white,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 20,
    ),
  );
}
