import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/repositories/api/portfolios/portfolios_repository.dart';

part 'trending_portfolio_state.dart';

class TrendingPortfolioCubit extends Cubit<TrendingPortfolioState> {
  final int pageSize;

  TrendingPortfolioCubit({required this.pageSize})
      : super(TrendingPortfolioInitial()) {
    getData();
  }

  Future<void> getData() async {

    final TrendingPortfolioResponse portfolioResponse =
        await GetIt.I.get<PortfoliosRepository>().getPortfolios(
              filter: "portfolios",
              page: 1,
              size: pageSize,
            );

    if (portfolioResponse.items == null) {
      emit(const TrendingPortfolioState(data: []));
    } else {
      emit(TrendingPortfolioState(data: portfolioResponse.items!));
    }
  }
}
