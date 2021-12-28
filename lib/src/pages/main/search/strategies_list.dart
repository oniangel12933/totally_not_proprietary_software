import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:involio/src/pages/main/search/trending_cards.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/trending_strategy_cubit.dart';

class TrendingStrategyList extends StatefulWidget {
  const TrendingStrategyList({Key? key}) : super(key: key);

  @override
  _TrendingStrategyListState createState() => _TrendingStrategyListState();
}

class _TrendingStrategyListState extends State<TrendingStrategyList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingStrategyCubit, TrendingStrategyState>(
      builder: (context, TrendingStrategyState state) {
        return ListView.separated(
          itemCount: state.data.length,
          separatorBuilder: (BuildContext context, int index) => Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Divider(height: 1, color: AppColors.involioLineSeparator),
          ),
          itemBuilder: (BuildContext context, int index) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 18),
                      child: Text(
                        "${index + 1}.",
                        style: AppFonts.bodySmall
                            .copyWith(color: AppColors.involioWhiteShades100),
                      )),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TrendingCard(
                            title: state.data[index].name,
                            followerCount: state.data[index].followers,
                            investmentType: state.data[index].investmentType,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              state.data[index].owner?.name ?? "",
                              style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.involioWhiteShades100),
                            ),
                          ),
                        ]),
                  )
                ]);
          },
        );
      },
    );
  }
}
