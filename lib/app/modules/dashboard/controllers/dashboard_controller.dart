import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:asadel/app/data/StoreResponse.dart';
import 'package:asadel/app/data/ZoneResponse.dart';
import 'package:asadel/app/routes/app_pages.dart';
import 'package:asadel/common/storage/storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:intl/intl.dart';

import '../../../../common/api/data/all_api_url.dart';
import '../../../../common/api/data/api_helper.dart';
import '../../../../common/api/utils/utils.dart';
import '../../../../common/appColors.dart';
import '../../../../common/constant/prefs.dart';
import '../../../../main.dart';
import '../../../data/Alert2Response.dart';
import '../../../data/AlertResponse.dart';
import '../../../data/UsersResponse.dart';

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


  final RxInt _itemCount = 0.obs;
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


  Timer? timer;
  final ApiHelper _apiHelper = Get.find();

  final RxList<AlertTwoData> _getAlertslist = <AlertTwoData>[].obs;
  List<AlertTwoData> get getAlertslist => _getAlertslist.value;
  set getAlertslist(List<AlertTwoData> v) => _getAlertslist.assignAll(v);

  final RxList<String> _getDateslist = <String>[].obs;
  List<String> get getDateslist => _getDateslist.value;
  set getDateslist(List<String> v) => _getDateslist.assignAll(v);
  final RxList<dynamic> _getZone = <dynamic>[].obs;
  List<dynamic> get getZone => _getZone.value;
  set getZone(List<dynamic> v) => _getZone.assignAll(v);
  final RxList<dynamic> _getStore = <dynamic>[].obs;
  List<dynamic> get getStore => _getStore.value;
  set getStore(List<dynamic> v) => _getStore.assignAll(v);

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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  IOSFlutterLocalNotificationsPlugin flutterIOSLocalNotificationsPlugin=IOSFlutterLocalNotificationsPlugin();
  final RxString _firebase_device_token = ''.obs;
  String get firebase_device_token => _firebase_device_token.value;
  set firebase_device_token(String v) => _firebase_device_token.value = v;
  // final UsersData _getUserslist = <UsersData>[].obs;
  // UsersData get getUserslist => _getUserslist.value;
  // set getUserslist(List<UsersData> v) => _getUserslist.assignAll(v);


  final Rx<UsersData?> _getUsersList = Rx<UsersData?>(null);
  UsersData? get getUsersList => _getUsersList.value;
  set getUsersList(UsersData? v) => _getUsersList.value = v;

  var iosDeviceInfos;
  var androidDeviceInfos;

  @override
  void onInit()async {
    super.onInit();
    shimmer=true;
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // var initializationSettingsAndroid = AndroidInitializationSettings('images/vmm_logo.png'); // <- default icon name is @mipmap/ic_launcher
    // var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = InitializationSettings(android: AndroidInitializationSettings(),iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin.initialize();

  // String? token = await FirebaseMessaging.instance.getToken();
  //   firebase_device_token=token??"";
  //   print(firebase_device_token.toString());
  //   NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: true,
  //     provisional: true,
  //     sound: true,
  //   );
  //   AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     importance: Importance.high,
  //   );
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     AppleNotification? ios = message.notification?.apple;
  //     if (notification != null && android != null && ios != null) {
  //       flutterIOSLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           notificationDetails: DarwinNotificationDetails(
  //               presentSound: true,
  //               presentBadge: true,
  //               presentAlert: true
  //           )
  //       );
  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //
  //           iOS: DarwinNotificationDetails(
  //             presentAlert: true,
  //             presentBadge: true,
  //             presentSound: true,
  //
  //           ),
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             // TODO add a proper drawable resource to android, for now using
  //             //      one that already exists in example app.
  //             icon: '@mipmap/ic_launcher',
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //   );
  //   FirebaseMessaging.onMessageOpenedApp.listen((event)async {
  //     print("Messing"+event.notification.toString());
  //     Get.toNamed(Routes.NOTIFICATION);
  //   });
  //
  //   print("FCM token $firebase_device_token");
    getUsersList=Storage.oneUserData;
    debugPrint('Save Data : ${json.encode(getUsersList!.role)}');
    if(getUsersList!=null ){
      selectRole=getUsersList!.role??'';
      userId=getUsersList!.userId??'';
      username=getUsersList!.userName??'';

    }


  }

  @override
  void onReady() {
    super.onReady();
    alertsApiPost();



  }

  void alertsApiPost() {

    if(selectRole=='Admin'){
      Utils.loadingDialog();
      _apiHelper.getAdminAlerts().futureValue((v) {
        printInfo(info: v.data.toString());

        if (v.data != null) {
       shimmer==false;
          Utils.closeDialog();
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();
          for(int i=0;i<getAlertslist.length;i++){
            // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => showNotificationWithActions(
            //     BuildContext,getAlertslist[i].queueLengthAlert!=null?getAlertslist[i].queueLengthAlert.toString():getAlertslist[i].waitTimeAlert.toString(),
            //     getAlertslist[i].zoneName.toString(),getAlertslist[i].storeName.toString(),DateFormat('dd/MM/yyyy').format(DateTime.parse(getAlertslist[i].updatedAt.toString()))));


            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());

            getZone.add(getAlertslist[i].zoneName.toString());

            getStore.add(getAlertslist[i].storeName.toString());

            debugPrint('getStore : ${json.encode(getStore)}');
          }

          print("Alerts : ${json.encode(v.data??[])}");
        }
      }
      );
    }
    else if(selectRole.toString().toLowerCase()=='zone supervisor'||selectRole.toString().toLowerCase()=='line supervisor'){
      _apiHelper.getZone().futureValue((v) {
        printInfo(info: v.data.toString());
        if (v.data != null) {
          shimmer==false;
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();
          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }
          // zoneApiPost();
          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }else if(selectRole.toString().toLowerCase()=='station master'){
      _apiHelper.getZone().futureValue((v) {
        printInfo(info: v.data.toString());
        if (v.data != null) {
          shimmer==false;
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();

          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }
          // zoneApiPost();
          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }


    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {

      if(itemCount!=Klimit){
        showNotificationWithActions(
            getAlertslist[itemCount].zoneName.toString(),
            getAlertslist[itemCount].storeName.toString(),
            getAlertslist[itemCount].queueLengthAlert!=null?getAlertslist[itemCount].queueLengthAlert.toString():getAlertslist[itemCount].waitTimeAlert.toString(),
            DateFormat('dd/MM/yyyy').format(DateTime.parse(getAlertslist[itemCount].updatedAt.toString())));



      }else{
        timer!.cancel();
      }
    });



  }

void refresAlertsApiPost() {

    if(selectRole=='Admin'){
      Utils.loadingDialog();
      _apiHelper.getAdminAlerts().futureValue((v) {
        printInfo(info: v.data.toString());

        if (v.data != null) {
       shimmer==false;
          Utils.closeDialog();
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();
          for(int i=0;i<getAlertslist.length;i++){
            // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => showNotificationWithActions(
            //     BuildContext,getAlertslist[i].queueLengthAlert!=null?getAlertslist[i].queueLengthAlert.toString():getAlertslist[i].waitTimeAlert.toString(),
            //     getAlertslist[i].zoneName.toString(),getAlertslist[i].storeName.toString(),DateFormat('dd/MM/yyyy').format(DateTime.parse(getAlertslist[i].updatedAt.toString()))));


            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());

            getZone.add(getAlertslist[i].zoneName.toString());

            getStore.add(getAlertslist[i].storeName.toString());

            debugPrint('getStore : ${json.encode(getStore)}');
          }







       // for(int n=0;n<10;n++){
          //   print("Notification");
          //   flutterLocalNotificationsPlugin.show(
          //       1,
          //       "Alert",
          //       getAlertslist[n].queueLengthAlert!=null?"Queue Length Alert":"Wait Time Alert",
          //       NotificationDetails(
          //
          //           iOS: DarwinNotificationDetails(
          //             presentAlert: true,
          //             presentBadge: true,
          //             presentSound: true,
          //           )));
          // }



          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }else if(selectRole.toString().toLowerCase()=='zone supervisor'){
      _apiHelper.getZone().futureValue((v) {
        printInfo(info: v.data.toString());
        if (v.data != null) {
          shimmer==false;
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();
          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }
          // zoneApiPost();
          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }else if(selectRole.toString().toLowerCase()=='station master'){
      _apiHelper.getZone().futureValue((v) {
        printInfo(info: v.data.toString());
        if (v.data != null) {
          shimmer==false;
          selectAlert='';
          selectZone='';
          selectDate='';
          selectStore='';
          getallAlertslist=v.data??[];
          getAlertslist=v.data??[];
          getAlertslist=getAlertslist.where((e)=>e.queueLengthAlert!=null||e.waitTimeAlert!=null).toList();

          for(int i=0;i<getAlertslist.length;i++){
            getDateslist.add(getAlertslist[i].updatedAt.toString().split("T")[0].toString());
          }
          // zoneApiPost();
          print("Alerts : ${json.encode(v.data??[])}");


        }
      }
      );
    }


  }


  // void zoneApiPost() {
  //   _apiHelper.getZone().futureValue((v) {
  //     printInfo(info: v.data.toString());
  //     if (v.data != null) {
  //       getZonelist=v.data??[];
  //       // getAlertslist=getAlertslist.where((e)=>e.zoneFootfall==selectZone).toList();
  //       StoreApiPost();
  //       print("Zone : ${json.encode(v.data??[])}");
  //
  //
  //     }
  //   }
  //   );
  // }
  // void StoreApiPost() {
  //   _apiHelper.getStore().futureValue((v) {
  //     printInfo(info: v.data.toString());
  //     if (v.data != null) {
  //       shimmer=false;
  //       getStorelist=v.data??[];
  //       // getAlertslist=getallAlertslist;
  //       if(selectRole=='Zone Supervisor'){
  //         getStorelist=getStorelist.where((e)=>e.zoneID==getZonelist[0].zoneID.toString()).toList();
  //       }else{
  //
  //       }
  //
  //       print("Zone : ${json.encode(v.data??[])}");
  //
  //
  //     }
  //   }
  //   );
  // }


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
                          timer!.cancel();


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

  Future<void> showNotificationWithActions(zone,store,alert,date) async {
    itemCount++;
    InAppNotification.show(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 100),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 12,
                  blurRadius: 16,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      width: 1.4,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zone: $zone",
                          style: TextStyle(
                            fontSize: Get.height/50,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          "Store: $store",
                          style: TextStyle(
                              fontSize: Get.height/60,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Text(
                          "Alert: $alert",
                          style: TextStyle(
                              fontSize: Get.height/65,
                              fontWeight: FontWeight.w200
                          ),
                        ),Text(
                          "Date: $date",
                          style: TextStyle(
                              fontSize: Get.height/70,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      context: Get.context!,
      onTap: () => debugPrint('Notification tapped!'),
      duration: Duration(milliseconds: 500),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }
}
