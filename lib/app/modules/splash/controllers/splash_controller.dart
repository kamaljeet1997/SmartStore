import 'dart:async';
import 'dart:convert';

import 'package:asadel/app/data/AppResponse.dart';
import 'package:asadel/common/constant/Constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/api/data/all_api_url.dart';
import '../../../../common/api/data/api_helper.dart';
import '../../../../common/api/utils/utils.dart';
import '../../../../common/constant/prefs.dart';
import '../../../../common/storage/storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  set loading(bool v) => _loading.value = v;

  @override
  void onInit() async {
    super.onInit();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast!.init(Get.context!);

  }

  @override
  void onReady() {
    super.onReady();
    usersdApiPost();
  }

  Future<bool> willPopCallback() async {
    return false;
  }

  void gotoLoginScreen() {
    Future.delayed(
      const Duration(milliseconds: 200),
    ).then(
          (value) =>
      Storage.userData != null
          ? Get.offAllNamed(Routes.DASHBOARD)
          : Get.offAllNamed(Routes.LOGIN),
    );
  }

  void usersdApiPost() async{
    Utils.loadingDialog();
    final dio = Dio();
    printInfo(info: "BaseURL: ${"$KBaseURL$KApp"}");
    final response = await dio.get(KBaseURL+KApp);
    AppResponse v=AppResponse.fromJson(response.data);
    printInfo(info: json.encode(v.data));
    if (v.data != null) {
      Storage.saveValue('BaseURL', v.data![0].baseUrl);
      Get.find<Prefs>().baseurl.val = v.data![0].baseUrl.toString();
      KBaseURL2="${v.data![0].baseUrl}"??'';
      KAdmin=v.data![0].admin??'';
      KUser=v.data![0].login??'';
      KZone=v.data![0].zone.toString().split(":")[0];
      KStore=v.data![0].store.toString().split(":")[0];
      Klimit=v.data![0].limit??0;
      debugPrint("Base URL ${Storage.getValue("BaseURL")}");
      loading = true;
      Timer.periodic(
        Duration(milliseconds: 200),
            (timer) {
          loading = !loading;
        },
      );
      gotoLoginScreen();
    }
    // _apiHelper.getApp().futureValue((v) {
    //   printInfo(info: v.data.toString());
    //
    // }
    // );
  }

}