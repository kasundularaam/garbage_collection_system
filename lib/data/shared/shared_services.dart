import 'package:shared_preferences/shared_preferences.dart';

class SharedServices {
  static const String uidKey = "uid";

  static Future<String> getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString(uidKey) ?? "1";
    return uid;
  }

  static Future addUser({required String uid}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(uidKey, uid);
  }

  static Future removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(uidKey);
  }

  static Future<bool> isUserIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String uid = preferences.getString(uidKey) ?? "";
    // return uid.isNotEmpty;
    return true;
  }
}
