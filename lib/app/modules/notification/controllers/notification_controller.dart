import 'package:get/get.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  final RxBool _showhide = false.obs;
  bool get showhide => _showhide.value;
  set showhide(bool v) => _showhide.value = v;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


}
