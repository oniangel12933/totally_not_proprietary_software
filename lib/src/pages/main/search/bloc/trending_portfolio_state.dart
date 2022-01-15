part of 'trending_portfolio_cubit.dart';

class TrendingPortfolioState extends Equatable {
  final List<AppApiTrendingSchemaPortfolio> data;

  const TrendingPortfolioState({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class TrendingPortfolioInitial extends TrendingPortfolioState {
  TrendingPortfolioInitial() : super(data: []);
}
