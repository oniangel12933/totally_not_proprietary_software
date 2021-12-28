import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
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
              hintText: AppLocalizations.of(context)!.search,
              errorText: '',
            ),
            style: AppFonts.body,
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
