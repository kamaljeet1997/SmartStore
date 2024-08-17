import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final RxString _username = ''.obs;
  String get username => _username.value;
  set username(String v) => _username.value = v;
  final RxString _selectRole = ''.obs;
  String get selectRole => _selectRole.value;
  set selectRole(String v) => _selectRole.value = v;
  final RxString _selectGender = ''.obs;
  String get selectGender => _selectGender.value;
  set selectGender(String v) => _selectGender.value = v;
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null){
      username=Get.arguments;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
