part of 'trending_portfolio_cubit.dart';

class TrendingPortfolioState extends Equatable {
  const TrendingPortfolioState({
    required this.data,
  });

  final List<AppApiTrendingSchemaPortfolio> data;

  @override
  List<Object> get props => [data];
}

class TrendingPortfolioInitial extends TrendingPortfolioState {
  TrendingPortfolioInitial() : super(data: []);

  @override
  List<Object> get props => [];
}
