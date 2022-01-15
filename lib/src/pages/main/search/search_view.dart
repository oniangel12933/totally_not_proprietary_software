import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/pages/main/search/search_input_decoration.dart';
import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'bloc/trending_portfolio_cubit.dart';
import 'bloc/trending_strategy_cubit.dart';
import 'bloc/trending_user_cubit.dart';
import 'discover_portfolios.dart';
import 'discover_strategies.dart';
import 'discover_users.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchTextController = TextEditingController();

/*  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingPortfolioCubit(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppThemes.edgePadding),
        child: _SearchInput(
          controller: searchTextController,
        ),
      ),
    );
  }*/


  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingPortfolioCubit>(
          create: (context) => TrendingPortfolioCubit(pageSize: 2),
        ),
        BlocProvider<TrendingStrategyCubit>(
          create: (context) => TrendingStrategyCubit(pageSize: 2),
        ),
        BlocProvider<TrendingUserCubit>(
          create: (context) =>
              TrendingUserCubit(pageSize: 20), //ToDo set pagination to 3 items
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppThemes.edgePadding),
        child: _SearchInput(
          controller: searchTextController,
        ),
      ),
    );
  }
}

class _SearchInput extends StatelessWidget {
  final TextEditingController controller;

  const _SearchInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          SizedBox(
            height: 36,
            child: InkWell(
              onTap: () => context.router.push(const UserSearchRoute()),
              child: IgnorePointer(
                child: TextField(
                  readOnly: true,
                  controller: controller,
                  key: const Key('discover_search_input_textField'),
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
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: const [
                  DiscoverTrendingPortfolios(),
                  DiscoverTrendingStrategies(),
                  DiscoverTrendingUsers(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
