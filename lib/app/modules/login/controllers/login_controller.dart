import 'dart:convert';

import 'package:asadel/common/constant/Constant.dart';
import 'package:asadel/common/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/api/data/all_api_url.dart';
import '../../../../common/api/data/api_helper.dart';
import '../../../../common/constant/prefs.dart';
import '../../../data/UsersResponse.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final ApiHelper _apiHelper = Get.find();
  final _body = <String, dynamic>{};
  final RxList<UsersData> _getUserslist = <UsersData>[].obs;
  List<UsersData> get getUserslist => _getUserslist.value;
  set getUserslist(List<UsersData> v) => _getUserslist.assignAll(v);
  final RxBool _passShowhide = true.obs;
  bool get passShowhide => _passShowhide.value;
  set passShowhide(bool v) => _passShowhide.value = v;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();



  final RxString _email = ''.obs;
  String get email => _email.value;
  set email(String v) => _email.value = v;


  final RxString _password = ''.obs;
  String get password => _password.value;
  set password(String v) => _password.value = v;
  final RxString _usersname= ''.obs;
  String get usersname => _usersname.value;
  set usersname(String v) => _usersname.value = v;
  final RxString _role = ''.obs;
  String get role => _role.value;
  set role(String v) => _role.value = v;


  @override
  void onInit() {
    super.onInit();
    fToast = FToast();
    fToast!.init(Get.context!);
  }

  @override
  void onReady() {
    super.onReady();
    if(Storage.userData!=null){
     getUserslist=Storage.userData!.data??[];
     getUserslist=getUserslist.where((e)=>e.password_D==Get.find<Prefs>().pass.val&& e.userEmail==Get.find<Prefs>().email.val).toList();
      print("getUserData : ${json.encode(getUserslist.toString())}");

      for(int i=0;i<getUserslist.length;i++){
       email=getUserslist[i].userEmail??"";
       password=getUserslist[i].password_D??"";
       usersname=getUserslist[i].userName??"";
       role=getUserslist[i].role??"";
      }
if(email==Get.find<Prefs>().email.val &&password==Get.find<Prefs>().pass.val){
  Map map={
    "email":email,
    "username":usersname,
    "password":password,
    "role":role
  };
  Get.offAllNamed(Routes.DASHBOARD,arguments:map);
}
}


  }

  void usersdApiPost() {
    _apiHelper.getUsers().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        Get.find<Prefs>().email.val='';
        Get.find<Prefs>().pass.val='';
        getUserslist = v.data??[];
        Storage.saveValue(Constants.USER_DATA, v);
        getUserslist=getUserslist.where((e)=>e.password_D==passwordcontroller.text && e.userEmail==emailcontroller.text).toList();
        Get.find<Prefs>().email.val = emailcontroller.text;
        Get.find<Prefs>().pass.val = passwordcontroller.text;
        Storage.saveValue(Constants.USER_DATA, v.data);
        print("getUserData : ${json.encode(getUserslist.toString())}");

        for(int i=0;i<getUserslist.length;i++){
          email=getUserslist[i].userEmail??"";
          password=getUserslist[i].password_D??"";
          usersname=getUserslist[i].userName??"";
          role=getUserslist[i].role??"";
        }

        if(email==emailcontroller.text && password==passwordcontroller.text){
          Map map={
            "email":email,
            "username":usersname,
            "password":password,
            "role":role
          };
          Get.offAllNamed(Routes.DASHBOARD,arguments:map);
        }else{
          Utils.shortAlertToast("Invalid credentials");
        }
      }
    }
    );
  }
}
