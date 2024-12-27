import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {

 static Future<void> setString(String key, String value) async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   await prefs.setString(key, value);
  }
 static Future<String?> getString(String key)async   {
   SharedPreferences prefs= await SharedPreferences.getInstance();
    String? value = prefs.getString(key) ;
    return value;
  }
  static Future<void> setInt(String key, int value) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
   await prefs.setInt(key, value);
  }
 static Future<int?> getInt(String key)  async {
   SharedPreferences prefs= await SharedPreferences.getInstance();
    int? value = prefs.getInt(key) ;
    return value;
  }
  static Future<void> setBool(String key,bool value)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
  static Future<bool> getBool(String key)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getBool(key)??false;
  }
}