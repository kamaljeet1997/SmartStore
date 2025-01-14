import 'dart:convert';

import 'package:asadel/app/data/StoreResponse.dart';
import 'package:asadel/app/data/ZoneResponse.dart';
import 'package:asadel/app/routes/app_pages.dart';
import 'package:asadel/common/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/api/data/api_helper.dart';
import '../../../../common/api/utils/utils.dart';
import '../../../../common/appColors.dart';
import '../../../data/Alert2Response.dart';
import '../../../data/AlertResponse.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  final RxString _username = ''.obs;
  String get username => _username.value;
  set username(String v) => _username.value = v;
  final RxBool _shimmer = false.obs;
  bool get shimmer => _shimmer.value;
  set shimmer(bool v) => _shimmer.value = v;
  final RxString _selectZone = ''.obs;
  String get selectZone => _selectZone.value;
  set selectZone(String v) => _selectZone.value = v;

  final RxInt _itemCount = 10.obs;
  int get itemCount => _itemCount.value;
  set itemCount(int v) => _itemCount.value = v;


  final RxString _selectStore = ''.obs;
  String get selectStore => _selectStore.value;
  set selectStore(String v) => _selectStore.value = v;

 final RxString _selectDate = ''.obs;
  String get selectDate => _selectDate.value;
  set selectDate(String v) => _selectDate.value = v;

 final RxString _selectAlert = ''.obs;
  String get selectAlert => _selectAlert.value;
  set selectAlert(String v) => _selectAlert.value = v;


  final RxString _base64 = ''.obs;
  String get base64 => _base64.value;
  set base64(String v) => _selectAlert.value = v;



  final ApiHelper _apiHelper = Get.find();

  final RxList<AlertTwoData> _getAlertslist = <AlertTwoData>[].obs;
  List<AlertTwoData> get getAlertslist => _getAlertslist.value;
  set getAlertslist(List<AlertTwoData> v) => _getAlertslist.assignAll(v);

  final RxList<AlertTwoData> _getallAlertslist = <AlertTwoData>[].obs;
  List<AlertTwoData> get getallAlertslist => _getallAlertslist.value;
  set getallAlertslist(List<AlertTwoData> v) => _getallAlertslist.assignAll(v);



  final RxList<ZoneData> _getZonelist = <ZoneData>[].obs;
  List<ZoneData> get getZonelist => _getZonelist.value;
  set getZonelist(List<ZoneData> v) => _getZonelist.assignAll(v);

  final RxList<StoreData> _getStorelist = <StoreData>[].obs;
  List<StoreData> get getStorelist => _getStorelist.value;
  set getStorelist(List<StoreData> v) => _getStorelist.assignAll(v);


  Map map=<String,dynamic>{};
  @override
  void onInit() {
    super.onInit();
    shimmer=false;
    if(Get.arguments!=null){
      map=Get.arguments;
      username=map['username'];
      print("Dashbaord   ${json.encode(map)}");
      alertsApiPost();
    }
  }

  @override
  void onReady() {
    super.onReady();

  }

  void alertsApiPost() {
    shimmer=false;
    _apiHelper.getAlerts().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {


        selectAlert='';
        selectZone='';
        selectDate='';
        selectStore='';
        getallAlertslist=v.data??[];
        getAlertslist=v.data??[];
        zoneApiPost();
        print("Alerts : ${json.encode(v.data??[])}");


      }
    }
    );
  }


  void zoneApiPost() {
    _apiHelper.getZone().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        getZonelist=v.data??[];
        // getAlertslist=getallAlertslist;
        // getAlertslist=getAlertslist.where((e)=>e.zoneFootfall==selectZone).toList();
        StoreApiPost();
        print("Zone : ${json.encode(v.data??[])}");


      }
    }
    );
  } void StoreApiPost() {
    _apiHelper.getStore().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        shimmer=true;
        getStorelist=v.data??[];
        // getAlertslist=getallAlertslist;
        // getAlertslist=getAlertslist.where((e)=>e.storeFootfall==selectStore).toList();

        print("Zone : ${json.encode(v.data??[])}");


      }
    }
    );
  }


  Widget drawer() {
    return Container(
      width: Get.width/1.3,
      child: Drawer(
        surfaceTintColor: AppColors.customtrans,
          child:  Container(
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: Get.height/15,left: 30),
                  child: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,
                    size: 30,),
                  ),
                ),

                Container(
                  height: Get.height / 2,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                  ListTile(
                  title: Text("Profile",
                    style:  TextStyle(
                        color:  AppColors.black,
                        fontSize: Get.height/45,
                        fontWeight: FontWeight.w500),),

              leading: Icon(Icons.person_2_outlined,

              size: Get.height/27,),
                    onTap: (){
                      Get.toNamed(Routes.PROFILE,arguments: username.toString());
                    },
                  ),

                      SizedBox(height: 20,),
                      ListTile(
                  title: Text("Notification Settings",
                    style:  TextStyle(
                        color:  AppColors.black,
                        fontSize: Get.height/45,
                    fontWeight: FontWeight.w500),),
              leading: Icon(Icons.notifications_none,
              size: Get.height/27,),
                        onTap: (){
                          Get.toNamed(Routes.NOTIFICATION_SETTING);
                        },
                  ),

                      SizedBox(height: 20,),
                      ListTile(
                  title: Text("Help & Support",
                    style:  TextStyle(
                        color:  AppColors.black,
                        fontSize: Get.height/45,
                        fontWeight: FontWeight.w500),),
              leading: Icon(Icons.help_outline_sharp,
              size: Get.height/27,),

                        onTap: (){
                    Utils.shortAlertToast("Under Development");

                        },
                  ),

                      SizedBox(height: 20,),
                      ListTile(
                  title: Text("Logout",
                    style:  TextStyle(
                        color:  AppColors.black,
                        fontSize: Get.height/45,
                        fontWeight: FontWeight.w500),),
              leading: Icon(Icons.person_2_outlined,
              size: Get.height/27,
              color: AppColors.white,),
                        onTap: (){
                          Storage.clearStorage();
                          shimmer=true;
                          Get.offAllNamed(Routes.LOGIN);
                        },
                  ),


                      SizedBox(height: 20,),
                    ],

                  ),
                )

              ],
            ),
          )
      ),
    );
  }

}
