import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/configs/configs.dart';
import '../models/app_user.dart';
import '../models/complain.dart';
import '../models/complain_req.dart';
import '../models/garbage_request.dart';
import '../models/garbage_request_req.dart';
import '../models/image_res.dart';
import '../models/login_res.dart';
import '../models/register_req.dart';

class HttpServices {
  final Dio dio;
  HttpServices._initialize({
    required this.dio,
  });

  static Future<HttpServices> initialize({bool isImageServer = false}) async {
    final Map<String, dynamic> urls = await _getDynamicUrls();

    final String mainServerIp = urls["main_server"];
    final String imageServerIp = urls["image_server"];
    final String baseUrl = isImageServer
        ? "http://$imageServerIp:8000/api"
        : "http://$mainServerIp:8000/api";

    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    final Dio dio = Dio(options);
    HttpServices httpServices = HttpServices._initialize(dio: dio);
    return httpServices;
  }

  static Future<Map<String, dynamic>> _getDynamicUrls() async {
    try {
      Response response = await Dio().get(staticUrlsJson);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AppUser> getUser({required int id}) async {
    try {
      Response response = await dio.get("/auth/register/$id");
      return AppUser.fromMap(response.data);
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<AppUser> register({required RegisterReq registerReq}) async {
    try {
      Response response =
          await dio.post("/auth/register/", data: registerReq.toMap());
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
      Response response = await dio
          .post("/auth/login/", data: {'email': email, 'password': password});
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

  Future<ImageRes> analyzeImage({required File image}) async {
    try {
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path),
      });
      Response response = await dio.post("/image/", data: formData);
      return ImageRes.fromMap(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<GarbageRequest> createGarbageRequest(
      {required GarbageRequestReq garbageRequestReq}) async {
    try {
      Response response =
          await dio.post("/request/", data: garbageRequestReq.toMap());
      return GarbageRequest.fromMap(response.data);
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<Complain> createComplain({required ComplainReq complainReq}) async {
    try {
      Response response =
          await dio.post("/complain/", data: complainReq.toMap());
      return Complain.fromMap(response.data);
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }

  Future<GarbageRequest> updateGarbageRequest(
      {required GarbageRequest request}) async {
    try {
      Response response =
          await dio.put("/request/${request.id}", data: request.toMap());
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
      Response response = await dio.get("/request/");
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
      Response response = await dio.get("/request/");
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

  Future<List<Complain>> getComplains({required String reqId}) async {
    try {
      Response response = await dio.get("/complain/");
      List<dynamic> resData = response.data;
      List<Complain> complains =
          resData.map((map) => Complain.fromMap(map)).toList();
      List<Complain> filtered = [];
      for (var complain in complains) {
        if (complain.reqId == reqId) {
          filtered.add(complain);
        }
      }
      return filtered;
    } on SocketException {
      throw "network_error".tr();
    } catch (e) {
      throw "error".tr();
    }
  }
}
