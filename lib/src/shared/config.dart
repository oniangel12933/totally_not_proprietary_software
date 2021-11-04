import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static AppConfig? _instance;

  factory AppConfig() => _instance ??= AppConfig._();

  AppConfig._();

  Future<void> setup() async {}

  String get baseUrl {
    return dotenv.env['BASE_URL'] ?? "baseUrl_not_setup";
  }
}
