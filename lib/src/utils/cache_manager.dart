import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static SharedPreferences? _sharedPreferences;

  // making class singleton

  // ignore: unused_field
  static final CacheManager _ = CacheManager.init();

  CacheManager.init() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  // cache functions
  static void cacheUserId(String userId) async {
    await _sharedPreferences?.setString('user_id', userId);
  }

  static cacheToken(String token) async {
    await _sharedPreferences?.setString('token', token);
  }

  static cacheBaseHost(String host) async {
    await _sharedPreferences?.setString('API_HOST', host);
  }

  // getters for cache data
  static String? get userId => _sharedPreferences?.getString('user_id');

  static String? get token => _sharedPreferences?.getString('token');

  static String? get apiHost => _sharedPreferences?.getString('API_HOST');
}
