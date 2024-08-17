import 'dart:convert';

import 'package:asadel/app/data/AlertResponse.dart';
import 'package:asadel/app/data/StoreResponse.dart';
import 'package:asadel/common/appColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/api/utils/utils.dart';
import '../../../../common/custom_dropDown_widget_ac.dart';
import '../../../data/Alert2Response.dart';
import '../../../data/ZoneResponse.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Obx(
            () => AppBar(
              surfaceTintColor: AppColors.customtrans,
              backgroundColor: AppColors.white,
              title: Text(
                  'Welcome, ${controller.username.toString().capitalizeFirst} '),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATION);
                    },
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: Get.height / 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: controller.drawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: 10, left: Get.width / 30,right:Get.width / 30 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Alerts : ${controller.getAlertslist.length.toString()}",
                      style: TextStyle(
                          color: AppColors.dark_gray.withOpacity(0.7),
                          fontWeight: FontWeight.normal,
                          fontSize: Get.height / 60),
                    ),

                    InkWell(
                      onTap: (){
                        controller.alertsApiPost();
                        // if(controller.emailcontroller.text.isEmpty){
                        //   Utils.shortAlertToast("Please Enter User Name");
                        // }else if (controller.passwordcontroller.text.isEmpty){
                        //   Utils.shortAlertToast("Please Enter Password");
                        // }else{
                        //   Get.offAllNamed(Routes.DASHBOARD,
                        //       arguments:controller.emailcontroller.text
                        //   );
                        // }
                      },
                      child: Icon(Icons.refresh)
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Row(
                children: [
                  controller.map['role']
                      .toString()
                      .toLowerCase() ==
                      "station master" ||
                      controller.map['role']
                          .toString()
                          .toLowerCase()
                           ==
                          "zone supervisor"
                      ? SizedBox.shrink()
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width / 30,
                                right: Get.width / 50,
                                top: Get.height / 80,
                                bottom: Get.width / 90),
                            child: Center(
                              child: CustomDropDownWidget<ZoneData>(
                                dataList: controller.getZonelist,
                                hinttext: controller.selectZone == ""
                                    ? "Zone"
                                    : controller.selectZone,
                                fontsize: Get.height / 45,
                                fontFamily: "Poppins-Regular",
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                hintStyle: TextStyle(
                                    color: AppColors.gray.withOpacity(0.7),
                                    fontSize: Get.width > 550
                                        ? Get.height / 70
                                        : Get.height / 60,
                                    fontFamily: 'Poppins-Medium'),
                                onChanged: (value) {
                                  controller.selectZone = value!.zoneName??'';
                                  controller.selectZoneId = value.zoneID??'';
                                  controller.getAlertslist= controller.getallAlertslist;
                                  controller. getAlertslist= controller.getAlertslist.where((e)=>e.zoneID== controller.selectZoneId).toList();

                                  //   controller.firebase_Ebook(value.classId!);
                                },
                                item: (data) => data.zoneName.toString(),
                              ),
                            ),
                          ),
                        ),
                  controller.map['role']
                      .toString()
                      .toLowerCase() ==
                      "station master"
                      ? SizedBox.shrink()
                      : controller.getStorelist.isEmpty?SizedBox.shrink():Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left:   controller.map['role']
                                    .toString()
                                    .toLowerCase()
                                    ==
                                    "zone supervisor"
                                    ?Get.width / 30:0,
                                right: Get.width / 50,
                                top: Get.height / 80,
                                bottom: Get.width / 90),
                            child: Center(
                              child: CustomDropDownWidget<StoreData>(
                                dataList:controller.getStorelist,
                                hinttext: controller.selectStore == ""
                                    ? "Store"
                                    : controller.selectStore,
                                fontsize: Get.height / 45,
                                fontFamily: "Poppins-Regular",
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                hintStyle: TextStyle(
                                    color: AppColors.gray.withOpacity(0.7),
                                    fontSize: Get.width > 550
                                        ? Get.height / 70
                                        : Get.height / 60,
                                    fontFamily: 'Poppins-Medium'),
                                onChanged: (value) {
                                  controller.selectStore = value!.storeName??'';
                                  controller.selectStoreId = value.storeID??'';
                                  controller.getAlertslist= controller.getallAlertslist;
                                  controller. getAlertslist= controller.getAlertslist.where((e)=>e.storeID==  controller.selectStoreId).toList();
                                  controller. getAlertslist= controller.getAlertslist.where((e)=>e.storeID==  controller.selectStoreId).toList();

                                  //   controller.firebase_Ebook(value.classId!);
                                },
                                item: (data) => data.storeName.toString(),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Obx(
              () => Row(
                children: [

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 30,
                          right: Get.width / 50,
                          top: Get.height / 80,
                          bottom: Get.width / 90),
                      child: Center(
                        child: CustomDropDownWidget<String>(
                          dataList: controller.getDateslist.toSet().toList(),
                          hinttext: controller.selectDate == ""
                              ? "Date"
                              : controller.selectDate,

                          fontsize: Get.height / 45,
                          fontFamily: "Poppins-Regular",
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          hintStyle: TextStyle(
                              color: AppColors.gray.withOpacity(0.7),
                              fontSize: Get.width > 550
                                  ? Get.height / 70
                                  : Get.height / 60,
                              fontFamily: 'Poppins-Medium'),
                          onChanged: (value) {
                            controller.selectDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(value!));
                            //   controller.firebase_Ebook(value.classId!);
                            controller.getAlertslist= controller.getallAlertslist;
                            controller. getAlertslist= controller.getAlertslist.where((e)=>DateFormat('dd/MM/yyyy').format(DateTime.parse(e.updatedAt.toString().split("T")[0].toString()))== controller.selectDate).toList();


                          },
                          item: (data) => DateFormat('dd/MM/yyyy').format(DateTime.parse(data.toString())),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: Get.width / 30,
                          top: Get.height / 80,
                          bottom: Get.width / 90),
                      child: Center(
                        child: CustomDropDownWidget<String>(
                          dataList: ["Queue Length Alert","Wait Time Alert"],
                          hinttext: controller.selectAlert == ""
                              ? "Alert"
                              : controller.selectAlert,
                          fontsize: Get.height / 45,
                          fontFamily: "Poppins-Regular",
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          hintStyle: TextStyle(
                              color: AppColors.gray.withOpacity(0.7),
                              fontSize: Get.width > 550
                                  ? Get.height / 70
                                  : Get.height / 60,
                              fontFamily: 'Poppins-Medium'),
                          onChanged: (value) {
                            controller.selectAlert = value.toString();


                            controller.getAlertslist= controller.getallAlertslist;
                            if(controller.selectAlert=="Queue Length Alert"){
                              controller. getAlertslist= controller.getAlertslist.where((e)=>e.queueLengthAlert!=null).toList();

                            }else{
                              controller. getAlertslist= controller.getAlertslist.where((e)=>e.waitTimeAlert!=null).toList();

                            }

                            //   controller.firebase_Ebook(value.classId!);
                          },
                          item: (data) => data.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () =>  controller.shimmer ==
                    false
                    ? ListView.builder(
                    shrinkWrap: true,
    itemCount: controller.getAlertslist.length,
    itemBuilder: (_, i) {
      return Shimmer
          .fromColors(
        baseColor: AppColors
            .header_color
            .withOpacity(
            0.2),
        highlightColor:
        AppColors
            .white,
        child:
        new Padding(
          padding:
          new EdgeInsets
              .all(
              10.0),
          child:
          new Container(
            height:
            Get.height /
                10,
            width:
            Get.height /
                5,
            decoration:
            BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(1)),
              color: Colors
                  .white,
            ),
          ),
        ),
      );

    }
                    )
                    :controller.getAlertslist.isEmpty
                    ?Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Data Not available",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.height/40
                        ),),

                      ],
                    ), Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please reset all filters",
                          style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Get.height/60
                          ),),

                      ],
                    ),

                  ],
                )

                    :ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getAlertslist.length,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            var image;
                            // var image=Base64Decoder().convert(controller.getAlertslist[i].queueLengthAlertUrl.toString().split('data:image/jpeg;base64,')[1]);
                            if(controller.getAlertslist[i].queueLengthAlertUrl!=null){
                              image=Base64Decoder().convert(controller.getAlertslist[i].queueLengthAlertUrl.toString().split('data:image/jpeg;base64,')[1]);
                            }else if(controller.getAlertslist[i].waitTimeAlertUrl!=null){
                              image=Base64Decoder().convert(controller.getAlertslist[i].waitTimeAlertUrl.toString().split('data:image/jpeg;base64,')[1]);
                            }
                            Get.dialog(Padding(
                              padding: EdgeInsets.only(
                                  top: Get.height / 6,
                                  bottom: Get.height / 6,
                                  left: Get.width / 30,
                                  right: Get.width / 30),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Material(
                                    child:  Padding(
                                      padding:  EdgeInsets.only(top: Get.height/30,left: Get.width/20,right: Get.width/20),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  controller.getAlertslist[i].queueLengthAlert!=null?"Queue Length Alert":"Wait Time Alert",
                                                  style: TextStyle(
                                                      fontSize: Get.height / 40,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: AppColors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            image!=null?Align(
                                                alignment: Alignment.center,
                                                child: Image.memory(
                                                  image,
                                                  // color: AppColors.black,
                                                )):SizedBox.shrink(),
                                            SizedBox(
                                              height: Get.height/50,
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Zone: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].zoneName!=null||controller.getAlertslist[i].zoneName!.isNotEmpty?controller.getAlertslist[i].zoneName.toString():"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                              Get.height / 50,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Store: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].storeName!=null|| controller.getAlertslist[i].storeName!.isNotEmpty?controller.getAlertslist[i].storeName.toString():"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                              Get.height / 50,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Counter: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].counterName!=null|| controller.getAlertslist[i].counterName!.isNotEmpty?controller.getAlertslist[i].counterName.toString():"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                              Get.height / 50,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                              height: 10,
                                            ),



                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Camera: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].cameraName!=null||controller.getAlertslist[i].cameraName!.isNotEmpty?controller.getAlertslist[i].cameraName.toString():"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                          Get.height / 50,
                                                          fontWeight:
                                                          FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Date: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: DateFormat('dd/MM/yyyy hh:mm aa').format(DateTime.parse(controller.getAlertslist[i].updatedAt??"")),
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                              Get.height / 50,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                       SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: Get.width / 30),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'ROI: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].roiid??'',
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize:
                                                              Get.height / 50,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),



                                          ],
                                        ),
                                    ),

                                  ),
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.black),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: Offset(0, 2))
                                ]),
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
                                            top: controller.getAlertslist[i].queueLengthAlert!=null&&controller.getAlertslist[i].waitTimeAlert!=null?10:0, left: Get.width / 30),
                                        child: Obx(
                                          ()=> controller.getAlertslist[i].queueLengthAlert!=null

                                              ?Row(
                                                children: [
                                                  Icon(Icons.notification_important,color: AppColors.gray.withOpacity(0.8),),
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                                                              text: TextSpan(
                                                  text: 'Alert: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 60,
                                                      fontWeight: FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].queueLengthAlert??"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize: Get.height / 60,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ],
                                                                                              ),
                                                                                            ),
                                                ],
                                              ):controller.getAlertslist[i].waitTimeAlert==null

                                              ?SizedBox()
                                              :Row(
                                                children: [
                                                  Icon(Icons.notification_important,color: AppColors.gray.withOpacity(0.8),),
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                                                              text: TextSpan(
                                                  text: 'Alert: ',
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: Get.height / 60,
                                                      fontWeight: FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: controller.getAlertslist[i].waitTimeAlert??"",
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize: Get.height / 60,
                                                          fontWeight:
                                                          FontWeight.normal),
                                                    ),
                                                  ],
                                                                                              ),
                                                                                            ),
                                                ],
                                              ),
                                        ),
                                      ),
                                      controller.map['role']
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "station master" ||
                                          controller.map['role']
                                                      .toString()
                                                      .toLowerCase()
                                                       ==
                                                  "zone supervisor"
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: Get.width / 30),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.location_city,color: AppColors.gray.withOpacity(0.8),),
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'Zone: ',
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize: Get.height / 60,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: controller.getAlertslist[i].zoneName==null||controller.getAlertslist[i].zoneName!.isEmpty?"":controller.getAlertslist[i].zoneName.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  AppColors.black,
                                                              fontSize:
                                                                  Get.height / 60,
                                                              fontWeight: FontWeight
                                                                  .normal),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      controller.map['role']
                                          .toString()
                                          .toLowerCase() ==
                                          "station master"
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: Get.width / 30),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.store,color: AppColors.gray.withOpacity(0.8),),
                                                  SizedBox(width: 10,),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'Store: ',
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize: Get.height / 60,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: controller.getAlertslist[i].storeName==null||controller.getAlertslist[i].storeName!.isEmpty?"":controller.getAlertslist[i].storeName.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  AppColors.black,
                                                              fontSize:
                                                                  Get.height / 60,
                                                              fontWeight: FontWeight
                                                                  .normal),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: Get.width / 30),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month,color: AppColors.gray.withOpacity(0.8),),
                                            SizedBox(width: 10,),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Date & Time: ',
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: Get.height / 60,
                                                    fontWeight: FontWeight.bold),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: controller.getAlertslist[i].updatedAt==null?"":DateFormat('dd/MM/yyyy hh:mm aa').format(DateTime.parse(controller.getAlertslist[i].updatedAt.toString())),
                                                    style: TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: Get.height / 60,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.black)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'images/login_bottom.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ));
  }
}
