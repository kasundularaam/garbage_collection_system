import '../../core/configs/configs.dart';

class DataProvider {
  static String get users => "$url/api/users";

  static String get login => "$url/auth/login/";
  static String get register => "$url/auth/register/";
  static String get requests => "$url/request";
  static String user(int id) => "$url/auth/register/$id";
}
