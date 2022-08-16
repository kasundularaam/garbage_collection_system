import 'package:dio/dio.dart';

import '../../core/configs/configs.dart';
import '../data_providers/data_provider.dart';
import '../models/app_user.dart';

import '../models/garbage_request.dart';
import '../models/garbage_request_req.dart';
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

  Future<AppUser> getUser({required int id}) async {
    try {
      Response response = await dio.get(DataProvider.user(id));
      return AppUser.fromMap(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> register({required RegisterReq registerReq}) async {
    try {
      Response response =
          await dio.post(DataProvider.register, data: registerReq.toMap());
      return AppUser.fromMap(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<LoginRes> login(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(DataProvider.login,
          data: {'email': email, 'password': password});
      final LoginRes loginRes = LoginRes.fromMap(response.data);
      if (loginRes.status == "SUCCESS") {
        return loginRes;
      } else {
        throw "An error occurred";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<GarbageRequest> createGarbageRequest(
      {required GarbageRequestReq garbageRequestReq}) async {
    try {
      Response response = await dio.post(DataProvider.requests,
          data: garbageRequestReq.toJson());
      return GarbageRequest.fromMap(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<GarbageRequest>> getGarbageRequestsById(
      {required int uid}) async {
    try {
      Response response = await dio.get(DataProvider.requests);
      List<dynamic> resData = response.data;
      List<GarbageRequest> requests =
          resData.map((map) => GarbageRequest.fromMap(map)).toList();
      return requests.reversed.toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<GarbageRequest>> getNewGarbageRequests() async {
    try {
      Response response = await dio.get(DataProvider.requests);
      List<dynamic> resData = response.data;
      List<GarbageRequest> requests =
          resData.map((map) => GarbageRequest.fromMap(map)).toList();
      List<GarbageRequest> pendingRequests = [];
      for (var req in requests) {
        if (req.status == "PENDING") {
          pendingRequests.add(req);
        }
      }
      return pendingRequests;
    } catch (e) {
      throw e.toString();
    }
  }
}
