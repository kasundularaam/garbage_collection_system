import 'package:shared_preferences/shared_preferences.dart';

class SharedAuth {
  static const String uidKey = "uid";
  static const String typeKey = "typeKey";

  static Future<int> getUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int uid = preferences.getInt(uidKey) ?? -1;
    return uid;
  }

  static Future<bool> isDriver() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String type = preferences.getString(typeKey) ?? "USER";
    // if (type == "USER") return false;
    return true;
  }

  static Future addUser({required int uid, required String type}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(uidKey, uid);
    preferences.setString(typeKey, type);
  }

  static Future removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(uidKey);
    preferences.remove(typeKey);
  }

  static Future<bool> isUserIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int uid = preferences.getInt(uidKey) ?? -1;
    return uid == -1 ? false : true;
  }
}
