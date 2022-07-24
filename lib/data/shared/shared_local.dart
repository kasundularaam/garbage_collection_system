import 'package:shared_preferences/shared_preferences.dart';

enum AppLocal { sinhala, english }

class SharedLocal {
  static const String localKey = "local";

  static Future<AppLocal> getLocal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String local = preferences.getString(localKey) ?? "english";
    if (local == "sinhala") {
      return AppLocal.sinhala;
    }
    return AppLocal.english;
  }

  static Future setLocal({required AppLocal local}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (local == AppLocal.sinhala) {
      preferences.setString(localKey, "sinhala");
    }
    preferences.setString(localKey, "english");
  }
}
