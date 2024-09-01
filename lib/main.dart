
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'app/routes/app_pages.dart';
import 'common/api/utils/initializer.dart';
import 'common/appColors.dart';
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   Get.toNamed(Routes.NOTIFICATION);
// }
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//  FlutterLocalNotificationsPlugin();
//
// IOSFlutterLocalNotificationsPlugin flutterIOSLocalNotificationsPlugin =
//  IOSFlutterLocalNotificationsPlugin();
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Initializer.instance.init(() async {
    runApp(InAppNotification(
      child: GetMaterialApp(
        title: "Application",
        builder: FToastBuilder(),
        initialRoute: AppPages.INITIAL,
        textDirection: TextDirection.ltr,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    ));
  });

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.customtrans,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();


}
