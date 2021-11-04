import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() =>
      _instance ??= SecureStorage._(const FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';
  static const _phoneKey = 'PHONE';

  Future<void> persistPhoneAndToken(String phone, String token) async {
    await _storage.write(key: _phoneKey, value: phone);
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }

  Future<bool> hasPhone() async {
    var value = await _storage.read(key: _phoneKey);
    return value != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<void> deletePhone() async {
    return _storage.delete(key: _phoneKey);
  }

  Future<String?> getPhone() async {
    return _storage.read(key: _phoneKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  /// todo: make sure that the token uses utc time
  Future<bool> isTokenExpired() async {
    String? token = await _storage.read(key: _tokenKey);
    if (token != null) {
      //Map<String, dynamic> payload = Jwt.parseJwt(token);
      DateTime? expirationDate = Jwt.getExpiryDate(token);
      if (expirationDate != null) {
        return DateTime.now().toUtc().isAfter(expirationDate);
      } else {
        return false;
      }
    }
    return true;
  }

  /// todo: make sure that the token uses utc time
  Future<Duration?> getTokenRemainingTime() async {
    String? token = await _storage.read(key: _tokenKey);
    if (token != null) {
      //Map<String, dynamic> payload = Jwt.parseJwt(token);
      DateTime? expirationDate = Jwt.getExpiryDate(token);
      if (expirationDate != null) {
        return expirationDate.difference(DateTime.now().toUtc());
      }
    }
    return null;
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}
