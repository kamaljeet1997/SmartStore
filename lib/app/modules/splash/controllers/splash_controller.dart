import 'dart:async';

import 'package:asadel/common/constant/Constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/api/data/all_api_url.dart';
import '../../../../common/api/data/api_helper.dart';
import '../../../../common/api/utils/utils.dart';
import '../../../../common/storage/storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final ApiHelper _apiHelper = Get.find();
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

  void usersdApiPost() {
    Utils.loadingDialog();
    _apiHelper.getApp().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        Utils.closeDialog();
        KBaseURL=v.data![0].baseUrl??'';
        KAdmin=v.data![0].admin??'';
        KZone=v.data![0].zone??'';
        KStore=v.data![0].store??'';
        Klimit=v.data![0].limit??0;
        loading = true;
        Timer.periodic(
          Duration(milliseconds: 200),
              (timer) {
            loading = !loading;
          },
        );
        gotoLoginScreen();
      }
    }
    );
  }

}