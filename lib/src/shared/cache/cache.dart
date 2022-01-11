import 'package:shared_preferences/shared_preferences.dart';

class SimpleCache {
  static const String valuePrefix = 'ca_val_';
  static const String timestampPrefix = 'ca_ts_';

  late Duration maxAge;

  SimpleCache() {
    maxAge = const Duration(minutes: 1);
  }

  void close() {}

  // if the cache is used more,
  // _sharedPreferences can be moved into an instance variable
  // currently it does need to be take up the memory
  Future<SharedPreferences> get _getSharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    SharedPreferences prefs = await _getSharedPreferences;

    Set<String> keys = prefs
        .getKeys()
        .where(
            (k) => k.startsWith(valuePrefix) || k.startsWith(timestampPrefix))
        .toSet();

    for (String key in keys) {
      prefs.remove(key);
    }
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await _getSharedPreferences;
    return prefs.containsKey(_getValueKey(key));
  }

  Future<String?> getStringFromCacheElseFunction(
      String key, Future<String> Function() f) async {
    SharedPreferences prefs = await _getSharedPreferences;

    bool contains = await containsKey(key);
    bool expired = await _checkIfKeyIsExpired(key);

    if (!contains || expired) {
      String result = await f();
      await setString(key: key, value: result);
    }
    return prefs.getString(_getValueKey(key));
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await _getSharedPreferences;

    bool contains = await containsKey(key);
    bool expired = await _checkIfKeyIsExpired(key);

    if (!contains || expired) {
      return null;
    }
    return prefs.getString(_getValueKey(key));
  }

  Future<void> reload() async {
    SharedPreferences prefs = await _getSharedPreferences;
    await prefs.reload();
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await _getSharedPreferences;
    await prefs.remove(_getTimestampKey(key));
    return prefs.remove(_getValueKey(key));
  }

  Future<bool> setString({required String key, required String value}) async {
    SharedPreferences prefs = await _getSharedPreferences;
    await _setTimeStampForKey(key);
    return prefs.setString(_getValueKey(key), value);
  }

  String _getValueKey(String forKey) {
    return valuePrefix + forKey;
  }

  String _getTimestampKey(String forKey) {
    return timestampPrefix + forKey;
  }

  bool _isTimestampExpired(int ts) {
    int diff = DateTime.now().millisecondsSinceEpoch - ts;
    return diff > maxAge.inMilliseconds;
  }

  Future<bool> _checkIfKeyIsExpired(String key) async {
    SharedPreferences prefs = await _getSharedPreferences;
    int? ts = prefs.getInt(_getTimestampKey(key));
    return ts == null || _isTimestampExpired(ts);
  }

  Future _setTimeStampForKey(String key) async {
    SharedPreferences prefs = await _getSharedPreferences;
    int ts = DateTime.now().millisecondsSinceEpoch;
    return prefs.setInt(_getTimestampKey(key), ts);
  }
}
