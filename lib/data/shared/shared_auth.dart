import 'package:shared_preferences/shared_preferences.dart';

class SharedAuth {
  static const String uidKey = "uid";
  static const String isDriverKey = "isDriver";

  static Future<String> getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString(uidKey) ?? "";
    return uid;
  }

  static Future<bool> isDriver() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isDriver = preferences.getBool(isDriverKey) ?? false;
    return isDriver;
  }

  static Future addUser({required String uid, required bool isDriver}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(uidKey, uid);
    preferences.setBool(isDriverKey, isDriver);
  }

  static Future removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(uidKey);
    preferences.remove(isDriverKey);
  }

  static Future<bool> isUserIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String uid = preferences.getString(uidKey) ?? "";
    return uid.isNotEmpty;
  }
}
