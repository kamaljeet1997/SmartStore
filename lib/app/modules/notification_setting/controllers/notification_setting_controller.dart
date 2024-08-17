import 'package:get/get.dart';

class NotificationSettingController extends GetxController {
  //TODO: Implement NotificationSettingController

  final RxBool _pushNotifications = true.obs;
  bool get pushNotifications => _pushNotifications.value;
  set pushNotifications(bool v) => _pushNotifications.value = v;


  final RxBool _emailNotifications = true.obs;
  bool get emailNotifications => _emailNotifications.value;
  set emailNotifications(bool v) => _emailNotifications.value = v;



  final RxBool _smsNotifications = true.obs;
  bool get smsNotifications => _smsNotifications.value;
  set smsNotifications(bool v) => _smsNotifications.value = v;



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
