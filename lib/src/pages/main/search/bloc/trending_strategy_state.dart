part of 'trending_strategy_cubit.dart';

class TrendingStrategyState extends Equatable {
  const TrendingStrategyState({
    required this.data,
  });

  final List<AppApiTrendingSchemaStrategy> data;

  @override
  List<Object> get props => [data];
}

class TrendingStrategyInitial extends TrendingStrategyState {
  TrendingStrategyInitial() : super(data: []);

  @override
  List<Object> get props => [];
}
