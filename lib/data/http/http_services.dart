import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

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
    dio.options.baseUrl = httpUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  List<GarbageRequest> garbageRequests = [];

  Future<AppUser> getUser({required int id}) async {
    try {
      Response response = await dio.get(DataProvider.user(id));
      return AppUser.fromMap(response.data);
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<AppUser> register({required RegisterReq registerReq}) async {
    try {
      Response response =
          await dio.post(DataProvider.register, data: registerReq.toMap());
      return AppUser.fromMap(response.data);
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
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
        throw "login_error".tr();
      }
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<GarbageRequest> createGarbageRequest(
      {required GarbageRequestReq garbageRequestReq}) async {
    try {
      Response response = await dio.post(DataProvider.requests,
          data: garbageRequestReq.toMap());
      return GarbageRequest.fromMap(response.data);
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<GarbageRequest> updateGarbageRequest(
      {required GarbageRequest request}) async {
    try {
      Response response = await dio.put(DataProvider.requestsWithId(request.id),
          data: request.toMap());
      return GarbageRequest.fromMap(response.data);
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
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
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
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
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }
}
