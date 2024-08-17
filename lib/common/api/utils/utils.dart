import 'dart:async';
import 'dart:io';
import 'package:asadel/app/routes/app_pages.dart';
import 'package:asadel/common/string.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../appColors.dart';
import '../data/all_api_url.dart';

/*
typedef GetLocationFunction = void Function(
    LatLng latLng,
    Address address,);
*/
enum StartingDayOfWeeks {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class Utils {
  const Utils._();

  static BoxDecoration get itemButtonDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.header_color),
      color: AppColors.header_color,
    );
  }

  static BoxDecoration get itemButtonDisableDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.light_grey_border),
      color: AppColors.light_grey_border,
    );
  }

  static BoxDecoration get itemQuizletDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.lig_gray.withOpacity(0.4),
          blurRadius: 4.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 5  horizontally
            0.0, // Move to bottom 5 Vertically
          ),
        )
      ],
    );
  }

  static BoxDecoration get matchingQuizDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.lig_gray.withOpacity(0.4),
          blurRadius: 4.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 5  horizontally
            0.0, // Move to bottom 5 Vertically
          ),
        )
      ],
    );
  }

  static BoxDecoration get settingButtonDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: AppColors.header_color),
      color: AppColors.header_color,
    );
  }

  static BoxDecoration get settingButtonDecoration2 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: AppColors.newdark_gray),
      color: AppColors.newdark_gray,
    );
  }

  static BoxDecoration get itemButtonLightGrayDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.light_grey),
      color: AppColors.light_grey,
    );
  }

  // Added by Vijay
  static BoxDecoration get itemButtonLightGrayDecoration1 {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.light_grey),
      color: AppColors.newdark_gray,
    );
  }

  static BoxDecoration get itemBlureButtonDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.header_color),
      color: AppColors.header_color.withOpacity(0.1),
    );
  }

  static BoxDecoration get itemButtonBorderDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.header_color),
    );
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  static void loadingDialog() {
    Get.defaultDialog(
      radius: 5,
      barrierDismissible: false,
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      content: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(left: Get.width / 10, right: Get.width / 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: Get.width / 35,
              ),
              Text(
                "Please Wait...",
                style: TextStyle(
                    color: AppColors.ligt_blck,
                    fontSize: Get.height / 55,
                    fontFamily: "Poppins-Bold"),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void progressButtonIndicator() {}

  static void fileuploadloadingDialog() {
    /*  double count=0.0;
    Timer.periodic(const Duration(seconds: 2), (Timer t) {
      count += 0.1;
      print(count);
    });
    AlertDialog(
      key: ValueKey(count),
      title: const Text("Loading..."),
      content: LinearProgressIndicator(
        value: count,
        backgroundColor: Colors.grey,
        color: Colors.green,
        minHeight: 10,
      ),
    );*/
    Get.defaultDialog(
      radius: 5,
      barrierDismissible: false,
      title: "",
      titlePadding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      content: Padding(
        padding: EdgeInsets.only(left: Get.width / 10, right: Get.width / 10),
        child: Container(
            child: Center(
                child: Image.asset(
          "images/uploading.gif",
          height: Get.height / 15,
        ))),
      ),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void shortSuccessToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.white),
              )),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void supportSuccessToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.white),
              )),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void supportBookMarkToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.white),
              )),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void longSuccessToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.green, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.white),
              )),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void shortErrorToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.white),
              ),
            )),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void shortAlertToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.toastalertcolor,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.black),
              ),
            )),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void longAlertToast(mesg) {
    fToast!.showToast(
      child: Padding(
        padding: EdgeInsets.only(left: Get.width / 50, right: Get.width / 50),
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.toastalertcolor,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                mesg,
                style: TextStyle(
                    fontSize: Get.height / 55, color: AppColors.black),
              ),
            )),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static void shortToast(mesg) {
    Fluttertoast.showToast(
        msg: mesg,
        fontSize: Get.height / 45,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  static void showToast(
      BuildContext context, String message, IconData iconData) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.transparent,
      textColor: Colors.transparent,
      fontSize: 0.0,
      webShowClose: true,
    );
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void longToast(mesg) {
    Fluttertoast.showToast(
      msg: mesg,
      fontSize: Get.height / 45,
      backgroundColor: AppColors.red,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static PreferredSize commonAppBar(
    String? title, {
    List<Widget>? action,
    iconTheme,
  }) =>
      PreferredSize(
          preferredSize: Size.fromHeight(Get.width > 550 ? 110 : 70),
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0),
            alignment: Alignment.topCenter,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xffFFFAF8),
                boxShadow: [BoxShadow(color: Color(0xfffaf8f7), blurRadius: 5)],
                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width > 550 ? Get.height / 30 : 0,
                  left: Get.width / 20,
                  right: Get.width / 20),
              child: AppBar(
                titleSpacing: 10,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  title!,
                  style: appBarSemiBoldStyle(),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFFAF8),
                centerTitle: false,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Get.width > 550 ? 8.0 : 15.0),
                    child: Container(
                      height: Get.width > 550 ? 50 : 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: Get.width > 550 ? 8 : 5),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.light_black,
                            size: Get.height / 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: action,
                iconTheme: iconTheme,
              ),
            ),
          ));

  static PreferredSize EvoxcommonAppBar(String? title,
          {List<Widget>? action, iconTheme, void Function()? onTap}) =>
      PreferredSize(
          preferredSize: Size.fromHeight(Get.width > 550 ? 110 : 70),
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0),
            alignment: Alignment.topCenter,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xffFFFAF8),
                boxShadow: [BoxShadow(color: Color(0xfffaf8f7), blurRadius: 5)],
                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width > 550 ? Get.height / 30 : 0,
                  left: Get.width / 20,
                  right: Get.width / 20),
              child: AppBar(
                titleSpacing: 10,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  title!,
                  style: appBarSemiBoldStyle(),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFFAF8),
                centerTitle: false,
                leading: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.all(Get.width > 550 ? 8.0 : 15.0),
                    child: Container(
                      height: Get.width > 550 ? 50 : 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: Get.width > 550 ? 8 : 5),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.light_black,
                            size: Get.height / 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: action,
                iconTheme: iconTheme,
              ),
            ),
          ));

  static PreferredSize KidsCommonAppBar(
    isMain,
    String? title,
    title2, {
    List<Widget>? action,
    iconTheme,
  }) =>
      PreferredSize(
          preferredSize: Size.fromHeight(Get.width > 550 ? 110 : 70),
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0),
            alignment: Alignment.topCenter,
            height: 200,
            color: AppColors.Kidswhite,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width > 550 ? Get.height / 30 : 0,
                  left: Get.width / 20,
                  right: Get.width / 20),
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                title: RichText(
                  text: TextSpan(
                      text: title,
                      style: KidsappBarSemiBoldStyle(),
                      children: [
                        TextSpan(
                          text: title2!,
                          style: kidsappBarSemiBoldStyle(),
                        )
                      ]),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFFAF8),
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: isMain == -1
                      ? SizedBox.shrink()
                      : Image.asset(
                          isMain == 0
                              ? 'images/kids_home.png'
                              : 'images/kids_cancel.png',
                        ),
                ),
                actions: action,
                iconTheme: iconTheme,
              ),
            ),
          ));

  static PreferredSize KidsDashboardAppBar(
    isMain,
    String? name,
    String? title,
    title2, {
    List<Widget>? action,
    iconTheme,
  }) =>
      PreferredSize(
          preferredSize: Size.fromHeight(Get.width > 550 ? 110 : 70),
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0),
            alignment: Alignment.topCenter,
            height: 200,
            color: AppColors.Kidswhite,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width > 550 ? Get.height / 30 : 0,
                  left: Get.width / 20,
                  right: Get.width / 20),
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                title: RichText(
                  text: TextSpan(
                      text: name!,
                      style: TextStyle(
                          color: AppColors.light_black,
                          fontSize: Get.height / 40,
                          fontFamily: "Poppins-Bold"),
                      children: [
                        TextSpan(
                          text: title,
                          style: KidsappBarSemiBoldStyle(),
                        ),
                        TextSpan(
                          text: title2!,
                          style: kidsappBarSemiBoldStyle(),
                        )
                      ]),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFFAF8),
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: isMain == -1
                      ? SizedBox.shrink()
                      : Image.asset(
                          isMain == 0
                              ? 'images/kids_home.png'
                              : 'images/kids_cancel.png',
                        ),
                ),
                actions: action,
                iconTheme: iconTheme,
              ),
            ),
          ));

  static PreferredSize commonAppBarAssessment(String? title, Function()? onTap,
          {List<Widget>? action}) =>
      PreferredSize(
          preferredSize: Size.fromHeight(Get.width > 550 ? 110 : 70),
          child: Container(
            margin: EdgeInsets.only(bottom: 0.0),
            alignment: Alignment.topCenter,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xffFFFAF8),
                boxShadow: [BoxShadow(color: Color(0xfffaf8f7), blurRadius: 5)],
                border: Border.all(color: AppColors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.width > 550 ? Get.height / 30 : 0,
                  left: Get.width / 20,
                  right: Get.width / 20),
              child: AppBar(
                titleSpacing: 10,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  title!,
                  style: appBarSemiBoldStyle(),
                ),
                elevation: 0.0,
                backgroundColor: Color(0xffFFFAF8),
                centerTitle: false,
                leading: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.all(Get.width > 550 ? 8.0 : 15.0),
                    child: Container(
                      height: Get.width > 550 ? 50 : 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: Get.width > 550 ? 8 : 5),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.light_black,
                            size: Get.height / 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: action,
              ),
            ),
          ));

  static PreferredSize commonDrawAppBar(title) {
    return PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          margin: EdgeInsets.only(bottom: 0.0),
          alignment: Alignment.topCenter,
          height: 200,
          decoration: BoxDecoration(
              color: Color(0xffFFFAF8),
              boxShadow: [BoxShadow(color: Color(0xfffaf8f7), blurRadius: 5)],
              border: Border.all(color: AppColors.black.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height / 20,
                left: Get.width / 20,
                right: Get.width / 20),
            child: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Text(
                title,
                style: appBarSemiBoldStyle(),
              ),
              elevation: 0.0,
              backgroundColor: Color(0xffFFFAF8),
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.light_black,
                  size: Get.height / 35,
                ),
              ),
            ),
          ),
        ));
  }

  static Padding floatingbutton(VoidCallback onPress) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width / 30, bottom: Get.height / 55),
      child: SizedBox(
        height: Get.height / 15,
        width: Get.height / 15,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          // mini: false,
          backgroundColor: AppColors.header_color,
          onPressed: onPress,
          elevation: 0.0,
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: Get.height / 27,
          ),
        ),
      ),
    );
  }

  static void alertDialog(
    String? message, {
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();

                onTap?.call();

                return true;
              },
        content: Text(message ?? Strings.somethingWentWrong,
            textAlign: TextAlign.center,
            maxLines: 6,
            style: TextStyle(color: AppColors.black)),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              //Get.offAllNamed(Routes.DASHBOARD);
              Get.offAllNamed(Routes.DASHBOARD);

              onTap?.call();
            },
            child: Container(
              child: Text(
                'ok',
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ),
      );

  static void homeworksubmitbystudentalertDialog(
    String? message, {
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();

                onTap?.call();

                return true;
              },
        content: Text(message ?? Strings.somethingWentWrong,
            textAlign: TextAlign.center,
            maxLines: 6,
            style: TextStyle(color: AppColors.black)),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              //Get.offAllNamed(Routes.DASHBOARD);
              Get.back();
              Get.back();
              Get.back();
              onTap?.call();
            },
            child: Container(
              child: Text(
                'ok',
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ),
      );

  static void homeworkcreatealertDialog(
    String? message, {
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();
                onTap?.call();
                return true;
              },
        content: Text(message ?? Strings.somethingWentWrong,
            textAlign: TextAlign.center,
            maxLines: 6,
            style: TextStyle(color: AppColors.black)),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              //Get.offAllNamed(Routes.DASHBOARD);
              // Get.offAllNamed(Routes.HOMEWORKCREATEDLISTTEACHER);

              onTap?.call();
            },
            child: Container(
              child: Text(
                'ok',
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ),
      );

  static void closeSnackbar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  static void showSnackbar(String? message) {
    closeSnackbar();

    Get.rawSnackbar(message: message);
  }

  static void showDialog(
    String? message, {
    String title = Strings.message,
    bool success = false,
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();

                onTap?.call();

                return true;
              },
        title: success ? Strings.success : title,
        content: Text(message ?? Strings.somethingWentWrong,
            textAlign: TextAlign.center,
            maxLines: 6,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 17,
                fontFamily: "Poppins-SemiBold")),
        confirm: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Get.back();

              onTap?.call();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                    color: AppColors.header_color,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontFamily: "Poppins-SemiBold"),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  static void showWebviewDialog(
    String? url, {
    String title = Strings.message,
    bool success = false,
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      Utils.commonViewPopup(
          Image.asset("images/Viewpanda.png", height: Get.height / 4),
          "View",
          "Are you sure you want to open it in a new browser?", () {
        launchURL(url);
      }, () {
        Get.back();
        onTap?.call();
      });
  /*Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();
                onTap?.call();
                return true;
              },
        title: success ? Strings.success : title,
        titleStyle: Utils.headingBoldStyle(),
        content: Text('Open link in browser?',
            textAlign: TextAlign.center,
            maxLines: 6,
            style: TextStyle(
                color: AppColors.black,
                fontSize: Get.height / 65,
                fontFamily: "Poppins-SemiBold")),
        confirm: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  onTap?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 30,
                    width: Get.width/6,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.height / 65,
                            fontFamily: "Poppins-SemiBold"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width / 30,
              ),
              InkWell(
                onTap: () {
                  launchURL(url);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 30,
                    width: Get.width/6,
                    decoration: BoxDecoration(
                        color: AppColors.header_color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.height / 65,
                            fontFamily: "Poppins-SemiBold"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );*/

  //=============================TextStyle Font and color ==============================//

/*---------------------text8---------------------*/
  static TextStyle textregular8sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 70,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textmedium8sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 70,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textsemiBold8sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 70,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle textbold8sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 70,
        fontFamily: 'Poppins-Bold');
  }

/*---------------------text10---------------------*/

  static TextStyle textregular10sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Regular');
  }

  // Added by Vijay
  static TextStyle textregular10spcustomlightgrey() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textmedium10sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10spcustomlightgrey() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10whitesp() {
    return TextStyle(
        color: AppColors.white,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10spCustomLightGrey() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  // Added by Vijay
  static TextStyle green_textmedium10sp() {
    return TextStyle(
        color: AppColors.green_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  // Added by Vijay
  static TextStyle red_textmedium10sp() {
    return TextStyle(
        color: AppColors.red_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10splight_grey() {
    return TextStyle(
        color: AppColors.light_grey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10spGray_text() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium10sp_header_color() {
    return TextStyle(
        color: AppColors.header_color,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textsemiBold10sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle textbold10sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins-Bold');
  }

  static TextStyle textPoppins10sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins');
  }

  static TextStyle textPoppinslightGrey10sp() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: 'Poppins');
  }

/*---------------------text11---------------------*/
  static TextStyle textregular11sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textregularlightgray11sp() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

/*---------------------text12---------------------*/
  static TextStyle textregular12sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 60,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textgreyregular12sp() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 60,
        fontFamily: 'Poppins-Regular');
  }

  // Added by Vijay
  static TextStyle textregular12sp_customlightgrey() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textregular12splight_Liver_black() {
    return TextStyle(
        color: AppColors.light_Liver_black,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmedium12sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textlightmedium12sp() {
    return TextStyle(
        color: AppColors.light_grey,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

// Added by Vijay
  static TextStyle textfieldmedium12sp() {
    return TextStyle(
        color: AppColors.lite_black_color,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle gray_textmedium12sp() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  //  added by Vijay
  static TextStyle whitetextmedium12sp() {
    return TextStyle(
        color: AppColors.customwhite,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textMediumGray12sp() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textsemiBold12sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle textmedium12dsp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 60,
        height: 1.0,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textbold12sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins-Bold');
  }

  static TextStyle textregularlight12sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 70 : Get.height / 60,
        fontFamily: 'Poppins');
  }

/*---------------------text14---------------------*/
  static TextStyle textregular14sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textregularThemeColor14sp() {
    return TextStyle(
        color: AppColors.header_color,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle textmedium14sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textmediumlightgrey14sp() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle textsemiBold14sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle textbold14sp() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 55,
        fontFamily: 'Poppins-Bold');
  }

  /*---------------------text16---------------------*/
  static TextStyle text16SPRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 50,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle text16SPMedium() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 50,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle text16SPSemiBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 50,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle text16SPBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 50,
        fontFamily: 'Poppins-Bold');
  }

  /*---------------------text18---------------------*/
  static TextStyle text18SPRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 45,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle text18SPMedium() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 45,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle text18SPSemiBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 45,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle text180SPBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 45,
        fontFamily: 'Poppins-Bold');
  }

  /*---------------------text20---------------------*/
  static TextStyle text20SPRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 50 : Get.height / 40,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle text20SPMedium() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 50 : Get.height / 40,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle text20SPSemiBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 50 : Get.height / 40,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle text20SPBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 50 : Get.height / 40,
        fontFamily: 'Poppins-Bold');
  }

  /*---------------------text22---------------------*/
  static TextStyle text22SPRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 35,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle text22SPMedium() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 35,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle text22SPSemiBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 35,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle text22SPBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 35,
        fontFamily: 'Poppins-Bold');
  }

/*---------------------text24---------------------*/
  static TextStyle text24SPRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 40 : Get.height / 30,
        fontFamily: 'Poppins-Regular');
  }

  static TextStyle text24SPMedium() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 40 : Get.height / 30,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle text24SPSemiBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 40 : Get.height / 30,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle text24SPBold() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 40 : Get.height / 30,
        fontFamily: 'Poppins-Bold');
  }

  //=============================End==============================//

  static TextStyle urlUnderlineStyle() {
    return TextStyle(
      decoration: TextDecoration.underline,
      color: AppColors.sky_blue,
      fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 65,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle customlightgreyMediumStyle() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 60,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle lightgreyMediumStyle() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 65,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle headingBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 65,
        fontFamily: 'Poppins-Bold');
  }

  static TextStyle headingBoldSecondStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle sideMenusStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 50,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle mainHeadingStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 45,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle mainHeadingStyle1() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 45,
        fontFamily: 'Poppins-SemiBold');
  }

  static TextStyle bookmarkStyle() {
    return TextStyle(
      color: AppColors.header_color,
      fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 55,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle selectDateStyle() {
    return TextStyle(
      color: AppColors.header_color,
      fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 55,
      fontFamily: 'Poppins-Medium',
    );
  }

  static TextStyle normalStyle() {
    return TextStyle(
        color: AppColors.light_black,
        fontSize: Get.width > 550 ? Get.height / 55 : Get.height / 55,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle normalStyleHeaderColor10SpMedium() {
    return TextStyle(
      color: AppColors.header_color,
      fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
      fontFamily: 'Poppins-Medium',
    );
  }

  // Added by Vijay
  static TextStyle normalStyle5() {
    return TextStyle(
        color: AppColors.light_black,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 60,
        fontFamily: "Poppins-Regular");
  }

  // Added by Vijay
  static TextStyle conversationDescriptionStyle() {
    return TextStyle(
        color: AppColors.light_black,
        fontSize: Get.width > 550 ? Get.height / 45 : Get.height / 45,
        fontFamily: "Poppins-Medium");
  }

  //Added by Vijay
  static TextStyle normalStyle2() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

  //Added by Vijay
  static TextStyle customlightgreyStyle() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle normalRedTextRegular10spStyle() {
    return TextStyle(
        color: AppColors.red,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

// added by vijay
  static TextStyle normalStyle1() {
    return TextStyle(
        color: AppColors.red_text,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle dropDownNormalStyle() {
    return TextStyle(
      color: AppColors.gray_text,
      fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 60,
      fontFamily: "Poppins-Medium",
    );
  }

  static TextStyle dropDownLiteStyle() {
    return TextStyle(
      color: AppColors.gray_text,
      fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
      fontFamily: "Poppins-Medium",
    );
  }

  static TextStyle dropDownBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 75,
        fontFamily: "Poppins-Bold");
  }

  static TextStyle headingNormalBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 50,
        fontFamily: "Poppins-SemiBold");
  }

  static TextStyle normalBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 55,
        fontFamily: "Poppins-SemiBold");
  }

/*--------------Setting Ui required-----------------*/
  static TextStyle normalBoldLiteBlackStyle() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 60 : Get.height / 55,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle setting12SpRegular() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 60,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle transport10SpMedium() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 60,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle transport10SpMediumLightGrey() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.width > 550 ? Get.height / 75 : Get.height / 60,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle setting10SpRegular() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.width > 550
            ? Get.height / 75
            : Get.width > 550
                ? Get.height / 75
                : Get.height / 60,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle normalSemiBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 60,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle normalLiteStyle() {
    return TextStyle(
        color: AppColors.light_grey,
        fontSize: Get.width > 550 ? Get.height / 65 : Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

// Added by Vijay

  static TextStyle normalLiteStyle6() {
    return TextStyle(
        color: AppColors.lite_black_color,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle normalLiteStyleNotice() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle normalStyleNotice() {
    return TextStyle(
        color: AppColors.light_black,
        fontSize: Get.height / 60,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle normalLightStyle() {
    return TextStyle(
        color: AppColors.customlightgrey,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle headingSemiBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-SemiBold");
  }

  static TextStyle appBarSemiBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 45,
        fontFamily: "Poppins-SemiBold");
  }

  static TextStyle kidsappBarSemiBoldStyle() {
    return TextStyle(
        color: AppColors.header_color,
        fontSize: Get.height / 40,
        fontFamily: "Poppins-Bold");
  }

  static TextStyle KidsappBarSemiBoldStyle() {
    return TextStyle(
        color: AppColors.newhome3color,
        fontSize: Get.height / 40,
        fontFamily: "Poppins-Bold");
  }

  static TextStyle KidsAppBlackBarSemiBoldStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 40,
        fontFamily: "Poppins-Bold");
  }

  static TextStyle appBarSemiBoldStyle1() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 45,
        fontFamily: "NovaFlat-Regular");
  }

  static TextStyle headingMediumStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-Medium");
  }

  static TextStyle settingMenuStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 50,
        fontFamily: "Poppins-Medium");
  }

//--------------------popup Style---------------------------//
  static TextStyle popupMediumStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 50,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle popupmediumStyle() {
    return TextStyle(
        color: AppColors.white,
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle popUpmediumStyle() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle popupTitleStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 50,
        fontFamily: 'Poppins-Bold');
  }

  static TextStyle popupnormalStyle() {
    return TextStyle(
        color: AppColors.ligt_blck,
        fontSize: Get.height / 55,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle popupNormalStyle() {
    return TextStyle(
        color: AppColors.gray_text,
        fontSize: Get.height / 60,
        fontFamily: "Poppins-Regular");
  }

  static TextStyle popupSemiBoldStyle(Color color) {
    return TextStyle(
        color: color,
        fontSize: Get.height / 65,
        fontFamily: "Poppins-SemiBold");
  }

  static TextStyle deletepopupSemiboldStyle(Color color) {
    return TextStyle(
        color: color,
        fontSize: Get.height / 50,
        fontFamily: "Poppins-SemiBold");
  }

//----------------------------itemButtonTextStyle----------------------------------//
  static TextStyle itemButtonMediumStyle() {
    return TextStyle(
        color: AppColors.white,
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  //Added by Vijay
  static TextStyle itemButtonMediumStyle5() {
    return TextStyle(
        color: AppColors.white,
        fontSize: Get.height / 55,
        fontFamily: 'Poppins-Medium');
  }

  //added by vijay
  static TextStyle itemButtonMediumStyle1() {
    return TextStyle(
        color: AppColors.settings_icon,
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static TextStyle itemButtonWhiteMediumStyle() {
    return TextStyle(
        color: AppColors.white,
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  // Added by Vijay
  static TextStyle itemButtonOrangeMediumStyle() {
    return TextStyle(
        color: Color(0xffed7c46),
        fontSize: Get.height / 65,
        fontFamily: 'Poppins-Medium');
  }

  static String universalDateFormat(
    String day,
    String month,
    String year,
  ) {
    return DateFormat('dd').format(DateTime.parse(day)) +
        " " +
        DateFormat('MMM').format(DateTime.parse(month)) +
        " " +
        DateFormat('yyyy').format(DateTime.parse(year));
  }

  static void showinappWebviewDialog(
    String? url, {
    String title = Strings.message,
    bool success = false,
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      commonViewPopup(
          Image.asset("images/Viewpanda.png", height: Get.height / 4),
          "View",
          "Are you sure you want to open it in a new browser?", () {
        inapplaunchURL(url);
      }, () {
        Get.back();
        onTap?.call();
      });

  static void gameinappWebviewDialog(
    String? url, {
    String title = Strings.message,
    bool success = false,
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      commonViewPopup(
          Image.asset("images/Viewpanda.png", height: Get.height / 4),
          "View",
          "Are you sure you want to open it in a new browser?", () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
        inapplaunchURL(url);
      }, () {
        Get.back();
        onTap?.call();
      });

  static void showinappWebviewEbookDialog(
    String? url,
    String msg, {
    String title = Strings.message,
    bool success = false,
    VoidCallback? onTap,
    bool addWillPopScope = true,
  }) =>
      commonViewPopup(
          Image.asset("images/Viewpanda.png", height: Get.height / 4),
          msg,
          "Are you sure you want to open it in a new browser?", () {
        inapplaunchURL(url);
      }, () {
        Get.back();
        onTap?.call();
      });
  /*  Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: !addWillPopScope
            ? null
            : () async {
                Get.back();

                onTap?.call();

                return true;
              },
        title: success ? Strings.success : title,
        titleStyle: Utils.headingBoldStyle(),
        content: Text(
          'Launch this link in a browser?',
          textAlign: TextAlign.center,
          maxLines: 6,
          style: TextStyle(
            color: AppColors.black,
            fontSize: Get.height / 65,
            fontFamily: "Poppins-SemiBold",
          ),
        ),
        confirm: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  onTap?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.height / 65,
                            fontFamily: "Poppins-SemiBold"),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width / 30,
              ),
              InkWell(
                onTap: () {
                  inapplaunchURL(url);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: AppColors.header_color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Okay',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: Get.height / 65,
                            fontFamily: "Poppins-SemiBold"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );*/

  static Future<void> showImagePicker({
    required Function(CroppedFile image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        Strings.gallery,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Strings.camera,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<CroppedFile?> getImage({int source = 1}) async {
    CroppedFile? croppedFile;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );
    if (pickedFile != null && pickedFile.path.isNotEmpty) {
      final image = File(pickedFile.path);
      croppedFile = await ImageCropper().cropImage(
          compressQuality: 50,
          sourcePath: image.path,
          // aspectRatioPresets: [
          //   CropAspectRatioPreset.square,
          //   CropAspectRatioPreset.ratio3x2,
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.ratio4x3,
          //   CropAspectRatioPreset.ratio16x9
          // ],
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: Colors.transparent,
              toolbarWidgetColor: Colors.transparent,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              minimumAspectRatio: 0.1,
              aspectRatioLockDimensionSwapEnabled: true,
            ),
          ]);
    }
    return croppedFile;
  }

  static void launchURL(String? u) async {
    Get.back();
    print("webview");
    Uri uri = Uri.parse(u!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      shortErrorToast('Could not launch $uri');
      throw 'Could not launch $uri';
    }
  }

  static void inapplaunchURL(String? u) async {
    Get.back();
    Uri uri = Uri.parse(u!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: WebViewConfiguration(
            enableJavaScript: true, enableDomStorage: true, headers: {}),
        // forceWebView: true,enableDomStorage: true,forceSafariVC: true,enableJavaScript: true
      );
    } else {
      throw 'Could not launch $uri';
    }
  }

  static BoxDecoration get commonDecoration {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.light_grey_border));
  }

  static BoxDecoration get kidsCommonDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      border: Border.all(color: AppColors.kids_light_border),
      gradient: RadialGradient(
        center: Alignment(0.5, 0.5),
        radius: 0.5,
        colors: [Colors.white, Color(0xFFf0fcf8)],
        stops: [0.0, 1.0],
      ),
    );
  }

  static BoxDecoration get buttoncommonDecoration {
    return BoxDecoration(
        color: AppColors.header_color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.light_grey_border));
  }

  static BoxDecoration get commonSGalleryDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.button_color),
      borderRadius: BorderRadius.circular(5.0),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration get onBoxDecoration {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: AppColors.light_grey.withOpacity(0.4),
          blurRadius: 4,
          spreadRadius: 0.2,
          offset: Offset(0, 0),
        ),
      ],
    );
  }

  // Added by Vijay
  static BoxDecoration get onBoxDecoration1 {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.customlightgrey));
  }

  static BoxDecoration get onschoolgallryBoxDecoration {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: AppColors.light_grey.withOpacity(0.8),
          blurRadius: 5,
          spreadRadius: 0.2,
          offset: Offset(0, 0),
        ),
      ],
    );
  }

  static ButtonStyle get questionPaperButtonStyle {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.white,
      padding: EdgeInsets.only(
          left: Get.width / 55,
          right: Get.width / 55,
          top: 3.0,
          bottom: 3.0), // Set padding around the button content
      minimumSize:
          Size(Get.width / 5, Get.height / 25), // Set the minimum button size
      maximumSize: Size(Get.width / 3, Get.height / 25),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: AppColors.header_color)),
    );
  }

  static ButtonStyle get questionPaperSelectedButtonStyle {
    return ElevatedButton.styleFrom(
      foregroundColor: AppColors.header_color,
      backgroundColor: AppColors.header_color,
      padding: EdgeInsets.only(
          left: Get.width / 55,
          right: Get.width / 55,
          top: 3.0,
          bottom: 3.0), // Set padding around the button content
      minimumSize:
          Size(Get.width / 5, Get.height / 25), // Set the minimum button size
      maximumSize: Size(Get.width / 3, Get.height / 25),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: AppColors.header_color)),
    );
  }

  static Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );

  static Widget Function(
    BuildContext context,
    Animation<double> animation,
  ) animationBuilder(
    Widget child, {
    double xOffset = 0,
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(xOffset, 0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          );

  static commonDeletePopup(Widget? images, String msg, String msgs,
          Function()? onTap, Function()? onTapCancel) =>
      Get.bottomSheet(Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height / 16),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: Material(
                child: Container(
                  width: Get.width,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 20, right: Get.width / 20),
                      child: Column(
                        children: [
                          images!,
                          Text(
                            msg,
                            style: deletepopupSemiboldStyle(
                                AppColors.button_color),
                          ),
                          SizedBox(
                            height: Get.height / 80,
                          ),
                          Text(
                            msgs,
                            style: popupNormalStyle(),
                          ),
                          SizedBox(
                            height: Get.height / 45,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              height: Get.height / 20,
                              width: Get.width / 4,
                              decoration: BoxDecoration(
                                color: AppColors.button_color,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Delete",
                                  style: popupmediumStyle(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 45,
                          ),
                          InkWell(
                            onTap: onTapCancel,
                            child: Text(
                              "Cancel",
                              style: popUpmediumStyle(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ));

  static commonBookmarkPopup(Widget? images, String msg, String msgs,
          Function()? onTap, Function()? onTapCancel, Widget text) =>
      Get.bottomSheet(Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height / 30),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Material(
                child: Container(
                  width: Get.width,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 20, right: Get.width / 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          images!,
                          Text(
                            msg,
                            style: deletepopupSemiboldStyle(
                                AppColors.button_color),
                          ),
                          SizedBox(
                            height: Get.height / 80,
                          ),
                          Text(
                            msgs,
                            textAlign: TextAlign.center,
                            style: popupNormalStyle(),
                          ),
                          SizedBox(
                            height: Get.height / 60,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              height: Get.height / 20,
                              width: Get.width / 3,
                              decoration: BoxDecoration(
                                color: AppColors.button_color,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(child: text),
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 45,
                          ),
                          InkWell(
                            onTap: onTapCancel,
                            child: Text(
                              "Cancel",
                              style: popUpmediumStyle(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ));

  static commonDownloadPopupE(
          Widget? images,
          String msg,
          String msgs,
          Function()? onTap,
          Function()? onTapCancel,
          String text,
          String value) =>
      Get.bottomSheet(
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height / 16),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Material(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      images!,
                      Text(
                        msg,
                        style: deletepopupSemiboldStyle(AppColors.button_color),
                      ),
                      SizedBox(
                        height: Get.height / 80,
                      ),
                      Text(
                        msgs,
                        style: popupNormalStyle(),
                      ),
                      SizedBox(
                        height: Get.height / 55,
                      ),
                      value == "true"
                          ? SizedBox.shrink()
                          : InkWell(
                              onTap: onTap,
                              child: Container(
                                height: Get.height / 20,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: AppColors.button_color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    text,
                                    style: popupmediumStyle(),
                                  ),
                                ),
                              ),
                            ),
                      value == "true"
                          ? SizedBox.shrink()
                          : SizedBox(
                              height: Get.height / 45,
                            ),
                      InkWell(
                        onTap: onTapCancel,
                        child: Text(
                          "Cancel",
                          style: popUpmediumStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  static commonshowdialog(
    Widget? images,
    String msg,
  ) =>
      Get.dialog(
        Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height / 3,
                bottom: Get.height / 3,
                left: Get.width / 20,
                right: Get.width / 20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Material(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      images!,
                      SizedBox(
                        height: Get.height / 80,
                      ),
                      Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: deletepopupSemiboldStyle(AppColors.button_color),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  static commonDownloadPopup(
    Widget? images,
    String msg,
    String msgs,
    Function()? onTap,
    Function()? onTapCancel,
    String text,
  ) =>
      Get.bottomSheet(Center(
        child: Padding(
          padding: EdgeInsets.only(top: Get.height / 16),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Material(
              child: Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    images!,
                    Text(
                      msg,
                      style: deletepopupSemiboldStyle(AppColors.button_color),
                    ),
                    SizedBox(
                      height: Get.height / 80,
                    ),
                    Text(
                      msgs,
                      style: popupNormalStyle(),
                    ),
                    SizedBox(
                      height: Get.height / 55,
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        height: Get.height / 20,
                        width: Get.width / 4,
                        decoration: BoxDecoration(
                          color: AppColors.button_color,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            text,
                            style: popupmediumStyle(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 45,
                    ),
                    InkWell(
                      onTap: onTapCancel,
                      child: Text(
                        "Cancel",
                        style: popUpmediumStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));

  static commonViewPopup(Widget? images, String msg, String msgs,
          Function()? onTap, Function()? onTapCancel) =>
      Get.bottomSheet(Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height / 16),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: Material(
                child: Container(
                  width: Get.width,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 20, right: Get.width / 20),
                      child: Column(
                        children: [
                          images!,
                          Text(
                            msg,
                            style: deletepopupSemiboldStyle(
                                AppColors.button_color),
                          ),
                          SizedBox(
                            height: Get.height / 80,
                          ),
                          Text(
                            msgs,
                            textAlign: TextAlign.center,
                            style: popupNormalStyle(),
                          ),
                          SizedBox(
                            height: Get.height / 55,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              height: Get.height / 20,
                              width: Get.width / 4,
                              decoration: BoxDecoration(
                                color: AppColors.button_color,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: popupmediumStyle(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 55,
                          ),
                          InkWell(
                            onTap: onTapCancel,
                            child: Text(
                              "Cancel",
                              style: popUpmediumStyle(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ));
  static commonLogoutPopup(Widget? images, String msg, String msgs,
          Function()? onTap, Function()? onTapCancel) =>
      Get.bottomSheet(Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height / 16),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Material(
                child: Container(
                  width: Get.width,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: Get.width / 20, right: Get.width / 20),
                      child: Column(
                        children: [
                          images!,
                          Text(
                            msg,
                            style: deletepopupSemiboldStyle(
                                AppColors.button_color),
                          ),
                          SizedBox(
                            height: Get.height / 80,
                          ),
                          Text(
                            msgs,
                            style: popupNormalStyle(),
                          ),
                          SizedBox(
                            height: Get.height / 45,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              height: Get.height / 20,
                              width: Get.width / 4,
                              decoration: BoxDecoration(
                                color: AppColors.button_color,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: popupmediumStyle(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 45,
                          ),
                          InkWell(
                            onTap: onTapCancel,
                            child: Text(
                              "Cancel",
                              style: popUpmediumStyle(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ));
}

class CustomToast extends StatelessWidget {
  final String message;
  final IconData iconData;

  CustomToast({required this.message, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
