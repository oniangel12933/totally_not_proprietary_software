import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:involio/src/pages/main/search/trending_cards.dart';
import 'package:involio/src/router/router.gr.dart';

import 'bloc/trending_portfolio_cubit.dart';

class DiscoverTrendingPortfolios extends StatefulWidget {
  const DiscoverTrendingPortfolios({Key? key}) : super(key: key);

  @override
  _DiscoverTrendingPortfoliosState createState() =>
      _DiscoverTrendingPortfoliosState();
}

class _DiscoverTrendingPortfoliosState extends State<DiscoverTrendingPortfolios> {
  @override
  void initState() {
    super.initState();

    context.read<TrendingPortfolioCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingPortfolioCubit, TrendingPortfolioState>(
      builder: (context, TrendingPortfolioState state) {
        return TrendingCategory(
          title: AppLocalizations.of(context)!.trendingPortfolios,
          onPressed: () =>
              context.router.push(const TrendingPortfoliosRoute()),
          child: SizedBox(
            height: 162, //TODO adjust height if trendingPortfolios.length < 2
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.data.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16.0),
              itemBuilder: (BuildContext context, int index) {
                return TrendingCard(
                  title: state.data[index].name!,
                  followerCount: state.data[index].followers!,
                  investmentType: state.data[index].investmentType!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
