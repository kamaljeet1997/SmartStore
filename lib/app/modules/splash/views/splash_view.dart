
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../../common/appColors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.white,
        child:  controller.loading==true
            ?Image.asset('images/vmm_logo.png',)
            :Image.asset('images/vmm_logo.png',),

      ),
    );
  }
}
