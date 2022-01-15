part of 'trending_strategy_cubit.dart';

class TrendingStrategyState extends Equatable {
  final List<AppApiTrendingSchemaStrategy> data;

  const TrendingStrategyState({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class TrendingStrategyInitial extends TrendingStrategyState {
  TrendingStrategyInitial() : super(data: []);
}
