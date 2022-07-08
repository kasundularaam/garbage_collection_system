import '../../core/configs/configs.dart';

class DataProvider {
  static String user(String uid) => "$url/api/users/$uid";

  static String get users => "$url/api/users";
}
