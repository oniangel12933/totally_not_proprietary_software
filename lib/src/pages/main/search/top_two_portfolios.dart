import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insidersapp/src/pages/main/search/trending_cards.dart';
import 'package:insidersapp/src/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/trending_portfolio_cubit.dart';

class TrendingPortfolioTopTwo extends StatefulWidget {
  const TrendingPortfolioTopTwo({Key? key}) : super(key: key);

  @override
  _TrendingPortfolioTopTwoState createState() =>
      _TrendingPortfolioTopTwoState();
}

class _TrendingPortfolioTopTwoState extends State<TrendingPortfolioTopTwo> {
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
              context.router.push(const PortfoliosTopTwentyRoute()),
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
