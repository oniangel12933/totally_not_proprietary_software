import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/repositories/api/api_client/api_client.dart';

class StrategiesRepository {
  Future<TrendingStrategyResponse> getStrategies({
    required String filter,
    required int page,
    required int size,
  }) async {
    var request = GetTrendingStrategies(
      context: AppSharedSchemasPageSchemaFilter(filter: filter),
      params: AppSharedSchemasPageSchemaParams(
        size: size,
        page: page,
      ),
    );

    Response response = await GetIt.I.get<Api>().dio.post(
        'api/social/trending/get_strategies',
        data: jsonEncode(request.toJson()));

    TrendingStrategyResponse trendingStrategyResponse =
        TrendingStrategyResponse.fromJson(response.data);
    return trendingStrategyResponse;
  }
}
