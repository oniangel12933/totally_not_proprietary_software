import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:insidersapp/src/extensions/string_extentions.dart';

class AppConfig {
  static AppConfig? _instance;

  factory AppConfig() => _instance ??= AppConfig._();

  AppConfig._();

  Future<void> setup() async {}

  String get baseUrl {
    return dotenv.get("BASE_URL", fallback: "https://api.insidersapp.io/");
  }

  bool get isProduction {
    String _isProductionString = dotenv.get(
      "IS_PRODUCTION",
      fallback: "false",
    );
    return stringToBool(_isProductionString);
  }
}
