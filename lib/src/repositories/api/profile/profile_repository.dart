import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/api_client/api_client.dart';

class ProfileRepository {
  final getIt = GetIt.instance;

  Future<GetAllInvestmentsResponse> getAllInvestments() async {
    var request = GetFeed(
        context: AppApiFeedSchemaFilter(), params: AppApiFeedSchemaParams());

    Response response = await getIt.get<Api>().dio.post(
        'api/user/investment/get_all_investments',
        data: jsonEncode(request.toJson()));

    GetAllInvestmentsResponse allInvestmentsResponse =
        GetAllInvestmentsResponse.fromJson(response.data);
    return allInvestmentsResponse;
  }

  Future<GetPortfolioAssets> getPortfolioAssets() async {
    var request = GetFeed(
        context: AppApiFeedSchemaFilter(), params: AppApiFeedSchemaParams());

    Response response = await getIt.get<Api>().dio.post(
        'api/user/asset/get_portfolio_assets',
        data: jsonEncode(request.toJson()));

    GetPortfolioAssets portfolioAssets =
        GetPortfolioAssets.fromJson(response.data);
    return portfolioAssets;
  }
}
