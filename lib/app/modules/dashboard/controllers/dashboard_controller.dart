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
import '../../../../common/constant/prefs.dart';
import '../../../data/Alert2Response.dart';
import '../../../data/AlertResponse.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  final RxString _username = ''.obs;
  String get username => _username.value;
  set username(String v) => _username.value = v;
  final RxBool _shimmer = true.obs;
  bool get shimmer => _shimmer.value;
  set shimmer(bool v) => _shimmer.value = v;
  final RxString _selectZone = ''.obs;
  String get selectZone => _selectZone.value;
  set selectZone(String v) => _selectZone.value = v;

  final RxString _selectZoneId = ''.obs;
  String get selectZoneId => _selectZoneId.value;
  set selectZoneId(String v) => _selectZoneId.value = v;


  final RxInt _itemCount = 10.obs;
  int get itemCount => _itemCount.value;
  set itemCount(int v) => _itemCount.value = v;


  final RxString _selectStore = ''.obs;
  String get selectStore => _selectStore.value;
  set selectStore(String v) => _selectStore.value = v;

   final RxString _selectStoreId = ''.obs;
  String get selectStoreId => _selectStoreId.value;
  set selectStoreId(String v) => _selectStoreId.value = v;



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

  final RxList<String> _getDateslist = <String>[].obs;
  List<String> get getDateslist => _getDateslist.value;
  set getDateslist(List<String> v) => _getDateslist.assignAll(v);

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

  final RxString _selectRole = ''.obs;
  String get selectRole => _selectRole.value;
  set selectRole(String v) => _selectRole.value = v;

  final RxString _userId = ''.obs;
  String get userId => _userId.value;
  set userId(String v) => _userId.value = v;


  @override
  void onInit() {
    super.onInit();
    shimmer=true;
    if(Get.arguments!=null){
      map=Get.arguments;
      username=map['username'];
      if(map['role']==null ||map['role']=='' ){
        selectRole=Get.find<Prefs>().role.val;
        userId=Get.find<Prefs>().userId.val;
      }else{
        selectRole=map['role'];
        userId=map['usersId'];
      }

      print("Role Dashboard   ${selectRole}");

    }

  }

  @override
  void onReady() {
    super.onReady();

    alertsApiPost();

  }

  void alertsApiPost() {

    if(selectRole=='Admin'){
      _apiHelper.getAdminAlerts().futureValue((v) {
        printInfo(info: v.data.toString());

        if (v.data != null) {
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }


          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }else{
      _apiHelper.getAlerts().futureValue((v) {
        printInfo(info: v.data.toString());
        if (v.data != null) {
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          if(selectRole=='Station Master'){
            getAlertslist=getAlertslist.where((e)=>e.userID==userId).toList();
            print("Alerts for store user only : ${json.encode(getAlertslist)}");

          }
          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }
          // zoneApiPost();
          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }
    if(selectRole=='Zone Supervisor' || selectRole=='Admin'){
      zoneApiPost();
    }else{
      StoreApiPost();
    }

  }


  void zoneApiPost() {
    _apiHelper.getZone().futureValue((v) {
      printInfo(info: v.data.toString());
      if (v.data != null) {
        getZonelist=v.data??[];
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
        shimmer=false;
        getStorelist=v.data??[];
        // getAlertslist=getallAlertslist;
        if(selectRole=='Zone Supervisor'){
          getStorelist=getStorelist.where((e)=>e.zoneID==getZonelist[0].zoneID.toString()).toList();
        }else{

        }

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
