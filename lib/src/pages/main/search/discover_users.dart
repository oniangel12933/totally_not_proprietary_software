import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/pages/main/search/trending_cards.dart';
import 'package:involio/src/pages/main/search/user_image_list.dart';
import 'package:involio/src/router/router.gr.dart';
import 'bloc/trending_user_cubit.dart';

class DiscoverTrendingUsers extends StatefulWidget {
  const DiscoverTrendingUsers({Key? key}) : super(key: key);

  @override
  _DiscoverTrendingUsersState createState() => _DiscoverTrendingUsersState();
}

class _DiscoverTrendingUsersState extends State<DiscoverTrendingUsers> {
  @override
  void initState() {
    super.initState();

    context.read<TrendingUserCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingUserCubit, TrendingUserState>(
        builder: (context, TrendingUserState state) {
      return TrendingCategory(
        title: AppLocalizations.of(context)!.trendingUsers,
        onPressed: () => context.router.push(const TrendingUsersRoute()),
        child: Column(
          children: const [
            UserImageList(),
          ],
        ),
      );
    });
  }
}
