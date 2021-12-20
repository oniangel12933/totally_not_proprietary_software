import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/repositories/api/strategies/strategies_repository.dart';

part 'trending_strategy_state.dart';

class TrendingStrategyCubit extends Cubit<TrendingStrategyState> {
  int pageSize;

  TrendingStrategyCubit({required this.pageSize})
      : super(TrendingStrategyInitial()) {
    getData();
  }

  Future<void> getData() async {
    final TrendingStrategyResponse strategyResponse =
        await GetIt.I.get<StrategiesRepository>().getStrategies(
              filter: "strategies",
              page: 1,
              size: pageSize,
            );

    if (strategyResponse.items == null) {
      emit(const TrendingStrategyState(data: []));
    } else {
      emit(TrendingStrategyState(data: strategyResponse.items!));
    }
  }
}
