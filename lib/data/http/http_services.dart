import 'package:dio/dio.dart';

import '../../core/configs/configs.dart';
import '../data_providers/data_provider.dart';
import '../models/app_user.dart';

import '../models/garbage_request.dart';
import '../models/login_res.dart';
import '../models/register_req.dart';

class HttpServices {
  Dio dio = Dio();

  HttpServices() {
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  List<GarbageRequest> garbageRequests = [];

  Future<AppUser> getUser({required int uid}) async {
    try {
      // Response response = await dio.get("$url/auth/user/");
      return AppUser(
          id: 5,
          username: "saman.k",
          mobileNo: 773612590,
          email: "rushanthasindu10@gmail.com",
          address: "B 34/1, Yataththawala, Imbulgasdeniya",
          password: "rushan",
          nic: "199716900992",
          type: "USER");
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> register({required RegisterReq registerReq}) async {
    try {
      Response response =
          await dio.post(DataProvider.register, data: registerReq.toMap());
      return response.data as AppUser;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> login(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(DataProvider.login,
          data: {'email': email, 'password': password});
      final LoginRes loginRes = LoginRes.fromMap(response.data);
      if (loginRes.status == "SUCCESS") {
        return AppUser(
            id: 5,
            username: "rushanthasindu10@gmail.com",
            mobileNo: 773612590,
            email: email,
            address: "B 34/1, Yataththawala, Imbulgasdeniya",
            password: password,
            nic: "199716900992",
            type: "USER");
      } else {
        throw "An error occurred";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<GarbageRequest> createGarbageRequest(
      {required GarbageRequest garbageRequest}) async {
    try {
      Response response = await dio.post(DataProvider.users);
      garbageRequests.add(garbageRequest);
      return garbageRequest;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<GarbageRequest>> getGarbageRequests({required int uid}) async {
    try {
      Response response = await dio.post(DataProvider.users);
      return garbageRequests;
    } catch (e) {
      throw e.toString();
    }
  }
}
