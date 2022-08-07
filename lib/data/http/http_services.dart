import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:garbage_collection_system/data/models/garbage_request.dart';
import 'package:garbage_collection_system/data/models/login_res.dart';
import 'package:garbage_collection_system/main.dart';

import '../../core/configs/configs.dart';
import '../data_providers/data_provider.dart';
import '../models/app_user.dart';
import 'package:http/http.dart' as http;

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
          username: "rushanthasindu10@gmail.com",
          mobile_no: 773612590,
          email: "rushanthasindu10@gmail.com",
          address: "B 34/1, Yataththawala, Imbulgasdeniya",
          password: "rushan",
          nic: "199716900992",
          type: "USER");
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> addUser({required AppUser user}) async {
    try {
      Response response =
          await dio.post("/auth/register/", queryParameters: user.toMap());
      return response.data as AppUser;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<AppUser> login(
  //     {required String email, required String password}) async {
  //   try {
  //     // log(email);
  //     Response response = await dio.post("$url/auth/login/",
  //         queryParameters: {'email': email, 'password': password});
  //     log(response.toString());
  //     return response.data as AppUser;
  //   } catch (e) {
  //     log(e.toString());
  //     throw e.toString();
  //   }
  // }
  Future<AppUser> login(
      {required String email, required String password}) async {
    try {
      log(DataProvider.login);
      final res = await http.post(
          Uri.parse(
            DataProvider.login,
          ),
          body: {"email": email, "password": password});
      if (res.statusCode == 200) {
        log(res.body);
        final LoginRes loginRes = LoginRes.fromJson(res.body);
        if (loginRes.status == "SUCCESS") {
          return AppUser(
              id: 5,
              username: "rushanthasindu10@gmail.com",
              mobile_no: 773612590,
              email: email,
              address: "B 34/1, Yataththawala, Imbulgasdeniya",
              password: password,
              nic: "199716900992",
              type: "USER");
        } else {
          throw "An error occurred";
        }
      } else {
        throw "An error occurred";
      }
    } catch (e) {
      log(e.toString());
      throw "Account not found";
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
