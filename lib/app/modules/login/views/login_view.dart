import 'dart:convert';

import 'package:asadel/app/routes/app_pages.dart';
import 'package:asadel/common/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../common/api/utils/utils.dart';
import '../../../../common/storage/storage.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            Padding(
              padding:  EdgeInsets.only(top: Get.height/13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height/4,
                    child: Image.asset('images/vmm_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height:  Get.height/35,),
            Text('Alert Notification System',
            style: TextStyle(
              color:AppColors.black,
              fontSize: Get.height/35,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height:  Get.height/35,),
                   Padding(
             padding:  EdgeInsets.only(top: Get.height/40,left: Get.width/20,right: Get.width/20),
             child: Column(
               children: [
                 TextField(
                   controller: controller.emailcontroller,
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(50)
                       ),
                     label:  Text('  Username',
                       style: TextStyle(
                           color:AppColors.grey,
                           fontSize: Get.height/50,
                           fontWeight: FontWeight.w500
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height:  Get.height/60,),
                 Obx(
                   ()=> TextField(
                     controller: controller.passwordcontroller,
                     obscureText: controller.passShowhide,
                     decoration: InputDecoration(
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(50)
                         ),
                       contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                       label:  Text('  Password',
                         style: TextStyle(
                             color:AppColors.grey,
                             fontSize: Get.height/50,
                             fontWeight: FontWeight.w500
                         ),
                       ),
                       suffixIcon: InkWell(
                         onTap: () {
                           controller.passShowhide =
                           !controller.passShowhide;
                         },
                         child: controller.passShowhide
                             ? Icon(Icons.visibility_off,
                           color: AppColors.button_color,
                         )
                             : Icon(Icons.visibility,
                           color: AppColors.button_color,
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height:  Get.height/20,),
                 InkWell(
                   onTap: (){

                     if(Storage.userData!=null){
                       Utils.loadingDialog();
                       controller.getUserslist=Storage.userData!.data??[];
                       controller.getUserslist=controller.getUserslist.where((e)=>e.password_D==controller.passwordcontroller.text && e.userEmail==controller.emailcontroller.text).toList();
                       print("getUserData : ${json.encode(controller.getUserslist.toString())}");

                       for(int i=0;i<controller.getUserslist.length;i++){
                         controller.email=controller.getUserslist[i].userEmail??"";
                         controller.password=controller.getUserslist[i].password_D??"";
                         controller.usersname=controller.getUserslist[i].userName??"";
                         controller.role=controller.getUserslist[i].role??"";
                       }

                       if(controller.email==controller.emailcontroller.text && controller.password==controller.passwordcontroller.text){
                         Map map={
                           "email":controller.email,
                           "username":controller.usersname,
                           "password":controller.password,
                           "role":controller.role
                         };
                         Utils.closeDialog();
                         Get.offAllNamed(Routes.DASHBOARD,arguments:map);
                       }else{
                         Utils.shortAlertToast("Invalid credentials");
                       }
                     }else{
                       controller.usersdApiPost();
                     }


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
                   child: Container(
                     height: Get.height/25,
                     width: Get.width/2.5,
                     decoration: BoxDecoration(
                       color: AppColors.button_color,
                       boxShadow: [BoxShadow(
                         color: AppColors.grey,
                         blurRadius: 2,
                         offset: Offset(0,7)
                       ),],
                       borderRadius: BorderRadius.circular(100),
                     ),
                     child: Center(
                       child: Text(
                         "Login",
                         style: TextStyle(
                             color:AppColors.white.withOpacity(0.8),
                             fontSize: Get.height/50,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height:  Get.height/60,),
                 Text(
                   "Forgot Password?" ,
                   style: TextStyle(
                       color:AppColors.button_color,
                       fontSize: Get.height/50,
                       fontWeight: FontWeight.normal
                   ),
                 ),
                 Align(
                   alignment: Alignment.bottomRight,
                   child: Padding(
                     padding:  EdgeInsets.only(top: Get.height/5),
                     child: Image.asset('images/login_bottom.jpg',
                       fit: BoxFit.fill,
                     ),
                   ),
                 ),
               ],
             ),
                   )

                  ],
                ),
          ),
        ));
  }
}
