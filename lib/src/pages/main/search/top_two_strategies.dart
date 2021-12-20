import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insidersapp/src/pages/main/search/trending_cards.dart';
import 'package:insidersapp/src/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/trending_strategy_cubit.dart';

class TrendingStrategyTopTwo extends StatefulWidget {
  const TrendingStrategyTopTwo({Key? key}) : super(key: key);

  @override
  _TrendingStrategyTopTwoState createState() => _TrendingStrategyTopTwoState();
}

class _TrendingStrategyTopTwoState extends State<TrendingStrategyTopTwo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingStrategyCubit, TrendingStrategyState>(
      builder: (context, TrendingStrategyState state) {
        return TrendingCategory(
          title: AppLocalizations.of(context)!.trendingStrategies,
          onPressed: () =>
              context.router.push(const StrategiesTopTwentyRoute()),
          child: SizedBox(
            height: 162, //TODO adjust height if trendingStrategies.length < 2
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
