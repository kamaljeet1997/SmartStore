
import 'package:asadel/app/data/Alert2Response.dart';
import 'package:asadel/app/data/AlertResponse.dart';
import 'package:asadel/app/data/AppResponse.dart';
import 'package:asadel/app/data/CameraResponse.dart';
import 'package:asadel/app/data/CounterResponse.dart';
import 'package:asadel/app/data/StoreResponse.dart';
import 'package:asadel/app/data/UsersResponse.dart';
import 'package:asadel/app/data/ZoneResponse.dart';
import 'package:asadel/common/storage/storage.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/Constant.dart';
import 'all_api_url.dart';
import 'api_helper.dart';
import 'package:get/get.dart';

class ApiHelperImpl extends GetConnect with ApiHelper {
  @override
  void onInit() {
    // httpClient.baseUrl = "${KBaseURL2==""?'http://122.160.201.198:3032/':KBaseURL2}/";
    // httpClient.timeout = Constants.timeout;
    addRequestModifier();
    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );
      return response;
    });
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>(
      (request) {
        // request.headers['Authorization'] =
        //     "Bearer " + Get.find<Prefs>().accessToken.val;
        // request.headers['schoolid'] =
        //     Get.find<Prefs>().schoolid.val == 'null' ||
        //             Get.find<Prefs>().schoolid.val.isEmpty
        //         ? ""
        //         : Get.find<Prefs>().schoolid.val;
        // request.headers['subdomain'] =
        //     Get.find<Prefs>().subdomain.val == 'null' ||
        //             Get.find<Prefs>().subdomain.val.isEmpty
        //         ? ""
        //         : Get.find<Prefs>().subdomain.val;

        printInfo(
          info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
              'url: ${request.url}\n'
              'Headers: ${request.headers}\n'
              'Body: ${request.files?.toString() ?? ''}\n',
        );
        return request;
      },
    );
  }

  @override
  Future<Response<UsersResponse>> getUsers() {
    var hh=Storage.getValue("BaseURL");
    debugPrint("getUsers URL : $hh");
    // TODO: implement Login
    return get(
            "$KBaseURL2/$KUser",
            decoder: (v) => UsersResponse.fromJson(v),
    );
  }

  @override
  Future<Response<Alert2Response>> getAlerts() {
    // TODO: implement getAlerts
    return get(
      "$KBaseURL2/$KAlert2",
      decoder: (v) => Alert2Response.fromJson(v),
    );
  }
  @override
  Future<Response<Alert2Response>> getAdminAlerts() {
    // TODO: implement getAlerts
    return get(
      "$KBaseURL2/$KAdmin",
      decoder: (v) => Alert2Response.fromJson(v),
    );
  }

  @override
  Future<Response<CameraResponse>> getCamera() {
    // TODO: implement getCamera
    return get(
      "$KBaseURL2/$KCamera",
      decoder: (v) => CameraResponse.fromJson(v),
    );
  }

  @override
  Future<Response<CounterResponse>> getCounter() {
    // TODO: implement getCounter
    return get(
      "$KBaseURL2/$KCounter",
      decoder: (v) => CounterResponse.fromJson(v),
    );
  }

  @override
  Future<Response<Alert2Response>> getStore(userId) {
    // TODO: implement getStore
    return get(
      "$KBaseURL2/$KStore$userId",
      decoder: (v) => Alert2Response.fromJson(v),
    );
  }

  @override
  Future<Response<Alert2Response>> getZone(userId) {
    // TODO: implement getZone
    return get(
      "$KBaseURL2/$KZone$userId",
      decoder: (v) => Alert2Response.fromJson(v),
    );
  }


  @override
  Future<Response<AppResponse>> getApp() {
    // TODO: implement getApp
    return get(
      KApp,
      decoder: (v) => AppResponse.fromJson(v),
    );
  }

  // @override
  // Future<Response<LoginResponse>> Login(
  //     FormData formData, Map<String, String> data) {
  //   // TODO: implement Login
  //   return post(
  //     KLogin,
  //     formData,
  //     headers: data,
  //     decoder: (v) => LoginResponse.fromJson(v),
  //   );
  // }


}
