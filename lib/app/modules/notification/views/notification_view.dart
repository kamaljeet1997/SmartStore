import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/api/utils/utils.dart';
import '../../../../common/appColors.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.customtrans,
        title:  Text('Notification',

        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:Column(
        children: [

          Expanded(
            child:  ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding:  EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){
                          controller.showhide=true;
                        },
                        child: Obx(
                            ()=> Container(
                            decoration: BoxDecoration(
                                color: controller.showhide==true?
                                AppColors.white
                                    :AppColors.gray.withOpacity(0.1),
                                // borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: AppColors.black),
                                ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: Get.width / 30),
                                        child: Text(
                                          "Queue Length Alert at Store A",
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: Get.height / 55,
                                                fontWeight:
                                                FontWeight.bold)
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: Get.width / 30),
                                        child: Text(
                                            "Date & Time: 2024-08-15 21:30" ,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: Get.height / 60,
                                                fontWeight:
                                                FontWeight.w500)
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: Get.width / 30),
                                        child: Text(
                                            "Zone: Zone 1" ,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: Get.height / 60,
                                                fontWeight:
                                                FontWeight.w500)
                                        )
                                      ),
                          
                                    ],
                                  ),
                                ),
                          
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'images/login_bottom.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      )
    );
  }
}
