import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:involio/src/extensions/string_extentions.dart';

class AppConfig {
  static AppConfig? _instance;

  factory AppConfig() => _instance ??= AppConfig._();

  AppConfig._();

  Future<void> setup() async {}

  String get baseUrl {
    return dotenv.get("BASE_URL",
        fallback:
            "https://ec2-3-94-128-128.compute-1.amazonaws.com/"); //"https://api.insidersapp.io/");
  }

  bool get isProduction {
    String _isProductionString = dotenv.get(
      "IS_PRODUCTION",
      fallback: "true",
    );
    return stringToBool(_isProductionString);
  }
}
