import 'package:dio/dio.dart';

import '../../core/configs/configs.dart';
import '../data_providers/data_provider.dart';
import '../models/app_user.dart';

class HttpServices {
  Dio dio = Dio();

  HttpServices() {
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  Future<AppUser> getUser({required String uid}) async {
    try {
      Response response = await dio.get(DataProvider.user(uid));
      return response.data as AppUser;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> addUser({required AppUser user}) async {
    try {
      Response response = await dio
          .post(DataProvider.users, data: {'id': user.uid, 'name': user.name});
      return response.data as AppUser;
    } catch (e) {
      throw e.toString();
    }
  }
}
