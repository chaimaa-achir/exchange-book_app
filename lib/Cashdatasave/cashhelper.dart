import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences _sharedPreferences; // declear
    static Future<void> cacheInitialisations() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

static Future<bool> setData({required String key, required dynamic value}) async {
  
  bool result = false;
  if (value is bool) {
    result = await _sharedPreferences.setBool(key, value);
  } else if (value is String) {
    result = await _sharedPreferences.setString(key, value);
  } else if (value is double) {
    result = await _sharedPreferences.setDouble(key, value);
  } else if (value is int) {
    result = await _sharedPreferences.setInt(key, value);
  }

  
  return result;
}


static dynamic getData({required String key}) {
  var value = _sharedPreferences.get(key);
  return value;
}


 static  Future<void> deleteitem({required String key}) async{
   await  _sharedPreferences.remove(key);
  }
}
