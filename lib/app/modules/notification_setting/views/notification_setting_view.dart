import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:asadel/common/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_setting_controller.dart';

class NotificationSettingView extends GetView<NotificationSettingController> {
  const NotificationSettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: Get.height/20, left: Get.width / 30,right:Get.width / 30 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Push Notifications",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: Get.height / 40,
                        fontWeight:
                        FontWeight.bold)
                ),
                Obx(
                ()=>Transform.scale(
                  scale:0.9,
                  transformHitTests: false,
                  child: Switch(
                    // activeColor: AppColors.green,
                activeTrackColor: AppColors.green,
                    // trackColor: AppColors.green,

                    onChanged: (v){
                      controller.pushNotifications=v;
                    },
                    value: controller.pushNotifications,
                  )
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Get.height/20, left: Get.width / 30,right:Get.width / 30 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Email Notifications",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: Get.height / 40,
                        fontWeight:
                        FontWeight.bold)
                ),
                Obx(
                      ()=>Transform.scale(
                      scale:0.9,
                      transformHitTests: false,
                      child: Switch(
                        // activeColor: AppColors.green,
                        activeTrackColor: AppColors.green,
                        // trackColor: AppColors.green,

                        onChanged: (v){
                          controller.emailNotifications=v;
                        },
                        value: controller.emailNotifications,
                      )
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Get.height/20, left: Get.width / 30,right:Get.width / 30 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "SMS Notification",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: Get.height / 40,
                        fontWeight:
                        FontWeight.bold)
                ),
                Obx(
                      ()=>Transform.scale(
                      scale:0.9,
                      transformHitTests: false,
                      child: Switch(
                        // activeColor: AppColors.green,
                        activeTrackColor: AppColors.green,
                        // trackColor: AppColors.green,

                        onChanged: (v){
                          controller.smsNotifications=v;
                        },
                        value: controller.smsNotifications,
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
