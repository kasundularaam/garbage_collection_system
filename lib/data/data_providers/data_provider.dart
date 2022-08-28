import '../../core/configs/configs.dart';

class DataProvider {
  static String get login => "$httpUrl/auth/login/";
  static String get register => "$httpUrl/auth/register/";
  static String get requests => "$httpUrl/request/";
  static String get complains => "$httpUrl/complain/";
  static String requestsWithId(int id) => "$httpUrl/request/$id";
  static String user(int id) => "$httpUrl/auth/register/$id";
}
