import 'dart:convert';

import 'package:asadel/app/data/AppResponse.dart';
import 'package:asadel/common/constant/Constant.dart';
import 'package:asadel/common/storage/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/api/data/all_api_url.dart';
import '../../../../common/api/data/api_helper.dart';
import '../../../../common/api/data/api_helper_imp.dart';
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


  final RxString _userId = ''.obs;
  String get userId => _userId.value;
  set userId(String v) => _userId.value = v;



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

  }

  void appApiPost() async{

    Utils.loadingDialog();
    final dio = Dio();
    printInfo(info: "BaseURL: ${"$KBaseURL$KApp"}");
    final response = await dio.get(KBaseURL+KApp);
    AppResponse v=AppResponse.fromJson(response.data);
    printInfo(info: json.encode(v.data));
    if (v.data != null) {
      KBaseURL2="${v.data![0].baseUrl}";
      Get.put<ApiHelper>(ApiHelperImpl(),);
      KAdmin=v.data![0].admin??'';
      KUser=v.data![0].login??'';
      KZone=v.data![0].zone.toString().split(":")[0];
      KStore=v.data![0].store.toString().split(":")[0];
      Klimit=v.data![0].limit??0;
      debugPrint("Base URL ${Storage.getValue("BaseURL")}");
      usersdApiPost();
    }
    // _apiHelper.getApp().futureValue((v) {
    //   printInfo(info: v.data.toString());
    //
    // }
    // );
  }



  void usersdApiPost() {
    Utils.loadingDialog();

    _apiHelper.getUsers().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        Utils.closeDialog();
        Get.find<Prefs>().email.val='';
        Get.find<Prefs>().pass.val='';
        getUserslist = v.data??[];
        Storage.saveValue(Constants.USER_DATA, v);
        getUserslist=getUserslist.where((e)=>e.password_D==passwordcontroller.text && e.userEmail==emailcontroller.text).toList();
        Get.find<Prefs>().email.val = emailcontroller.text;
        Get.find<Prefs>().pass.val = passwordcontroller.text;

        print("getUserData : ${json.encode(getUserslist)}");

        for(int i=0;i<getUserslist.length;i++){
          email=getUserslist[i].userEmail??"";
          password=getUserslist[i].password_D??"";
          usersname=getUserslist[i].userName??"";
          role=getUserslist[i].role??"";
          userId=getUserslist[i].userId??"";
          Get.find<Prefs>().role.val = role;
          Get.find<Prefs>().username.val = usersname;
          Get.find<Prefs>().userId.val = userId;
          Storage.saveValue(Constants.USER_DATA_LIST, getUserslist[i]);

        }
        print("getOneUserData : ${json.encode(Storage.oneUserData)}");


        if(email==emailcontroller.text && password==passwordcontroller.text){
          Map map={
            "email":email,
            "username":usersname,
            "password":password,
            "role":role,
            "usersId":userId,
            "list":getUserslist
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
