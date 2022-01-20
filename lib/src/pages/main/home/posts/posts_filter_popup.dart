import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/posts_filter_bloc.dart';

class PostsFilterModal extends StatelessWidget {
  //final PostsFilterBloc postsFilterBloc;

  const PostsFilterModal({
    Key? key,
    //required this.postsFilterBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentFilter = context
        .read<PostsFilterBloc>()
        .state
        .filterName; //postsFilterBloc.state.filterName;
    Color _blue = AppColors.involioBlue;
    Color _white = AppColors.involioWhiteShades80;

    return Material(
      color: (Theme.of(context).brightness == Brightness.dark)
          ? AppColors.involioFillFormBackgroundColor
          : AppColors.involioFillFormBackgroundColor,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 9, bottom: 20),
              width: 45,
              height: 5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: AppColors.involioGreenGrayBlue,
              ),
            ),
            const Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              minLeadingWidth: 0,
              horizontalTitleGap: 10,
              title: Text(
                AppLocalizations.of(context)!.trendingFilter,
                style: AppFonts.bodyBig.copyWith(
                  color: _currentFilter ==
                          AppLocalizations.of(context)!.trendingFilter.toLowerCase()
                      ? _blue
                      : _white,
                ),
              ),
              leading: Icon(
                context.involioIcons.trendUp,
                color: _currentFilter ==
                        AppLocalizations.of(context)!.trendingFilter.toLowerCase()
                    ? _blue
                    : _white,
              ),
              onTap: () {
                Navigator.pop(context,
                    AppLocalizations.of(context)!.trendingFilter.toLowerCase());
                context.read<PostsFilterBloc>().setFilter(
                    AppLocalizations.of(context)!.trendingFilter.toLowerCase());
              },
            ),
            const Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              minLeadingWidth: 0,
              horizontalTitleGap: 10,
              title: Text(
                AppLocalizations.of(context)!.followingFilter,
                style: AppFonts.bodyBig.copyWith(
                  color: _currentFilter ==
                          AppLocalizations.of(context)!.followingFilter.toLowerCase()
                      ? _blue
                      : _white,
                ),
              ),
              leading: Icon(
                context.involioIcons.followUserCircled,
                color: _currentFilter ==
                        AppLocalizations.of(context)!.followingFilter.toLowerCase()
                    ? _blue
                    : _white,
              ),
              onTap: () {
                Navigator.pop(context,
                    AppLocalizations.of(context)!.followingFilter.toLowerCase());
                context.read<PostsFilterBloc>().setFilter(
                    AppLocalizations.of(context)!.followingFilter.toLowerCase());
              },
            ),
            const Divider(height: 1, color: AppColors.involioLineSeparator),
            ListTile(
              minLeadingWidth: 0,
              horizontalTitleGap: 10,
              title: Text(
                AppLocalizations.of(context)!.myInterests,
                style: AppFonts.bodyBig.copyWith(
                  color: _currentFilter ==
                          AppLocalizations.of(context)!.interestsFilter.toLowerCase()
                      ? _blue
                      : _white,
                ),
              ),
              leading: Icon(
                context.involioIcons.heart,
                color: _currentFilter ==
                        AppLocalizations.of(context)!.interestsFilter.toLowerCase()
                    ? _blue
                    : _white,
              ),
              onTap: () {
                Navigator.pop(context,
                    AppLocalizations.of(context)!.interestsFilter.toLowerCase());
                context.read<PostsFilterBloc>().setFilter(
                    AppLocalizations.of(context)!.interestsFilter.toLowerCase());
              },
            ),
            const Divider(height: 1, color: AppColors.involioLineSeparator),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.involioBlue,
                  minimumSize: const Size.fromHeight(53),
                ),
                onPressed: () => {Navigator.of(context).pop()},
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: AppFonts.headline6
                      .copyWith(color: AppColors.involioWhiteShades80),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
