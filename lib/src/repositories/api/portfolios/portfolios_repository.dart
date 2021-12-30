import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';

class PortfoliosRepository {
  Future<TrendingPortfolioResponse> getPortfolios({
    required String filter,
    required int page,
    required int size,
  }) async {
    var request = GetTrendingPortfolios(
      context: AppSharedSchemasPageSchemaFilter(filter: filter),
      params: AppSharedSchemasPageSchemaParams(
        page: page,
        size: size,
      ),
    );

    Response response = await GetIt.I.get<Api>().dio.post(
        'api/social/trending/get_portfolios',
        data: jsonEncode(request.toJson()));

    TrendingPortfolioResponse trendingPortfolioResponse =
        TrendingPortfolioResponse.fromJson(response.data);
    return trendingPortfolioResponse;
  }
}
