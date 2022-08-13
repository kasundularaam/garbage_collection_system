import 'dart:convert';
import 'dart:developer';

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

  Future<AppUser> getUser({required int id}) async {
    try {
      Response response = await dio.get(DataProvider.user(id));
      return AppUser.fromJson(response.toString());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> register({required RegisterReq registerReq}) async {
    try {
      Response response =
          await dio.post(DataProvider.register, data: registerReq.toMap());
      return AppUser.fromJson(response.toString());
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
      Response response = await dio.get(DataProvider.requests);
      List<dynamic> resData = response.data;
      List<GarbageRequest> requests =
          resData.map((map) => GarbageRequest.fromMap(map)).toList();
      return requests;
    } catch (e) {
      log(e.toString());

      throw e.toString();
    }
  }
}
