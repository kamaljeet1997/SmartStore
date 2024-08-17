import 'package:asadel/common/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/api/utils/utils.dart';
import '../../../../common/custom_dropDown_widget_ac.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        title: const Text('Profile '),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.height/30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      shape: BoxShape.circle
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                    ()=> Text(
                      controller.username,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: Get.height / 40,
                          fontWeight:
                          FontWeight.bold)
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                        "Profile",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: Get.height / 40,
                            fontWeight:
                            FontWeight.bold)
                    ),
                  
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/30,right: Get.width/30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                            hintText: "First Name"
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width/20,),
                  Expanded(
                    child: Container(
                      height: Get.height/17,
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: AppColors.gray.withOpacity(0.3)
                                )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "Last Name"
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/30,right: Get.width/30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: CustomDropDownWidget<String>(
                          dataList: [
                            'Admin',
                            'Zone Manager',
                            'Store Manager'
                          ],
                          hinttext: controller.selectRole == ""
                              ? "Role"
                              : controller.selectRole,
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
                            controller.selectRole = value!;
                            //   controller.firebase_Ebook(value.classId!);
                          },
                          item: (data) => data.toString(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width/20,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: CustomDropDownWidget<String>(
                          dataList: [
                            'Male',
                            'Female',
                            'Transgender'
                          ],
                          hinttext: controller.selectGender == ""
                              ? "Gender"
                              : controller.selectGender,
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
                            controller.selectGender = value!;
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

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "Email:",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: Get.height / 40,
                          fontWeight:
                          FontWeight.bold)
                  ),
                  SizedBox(width:Get.width/30),
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "Email Address"
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "Phone:",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: Get.height / 40,
                          fontWeight:
                          FontWeight.bold)
                  ),
                  SizedBox(width:Get.width/30),
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "Phone number"
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
            SizedBox(height:  Get.height/20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Utils.shortAlertToast("Profile Updated");
                  },
                  child: Container(
                    height: Get.height/25,
                    width: Get.width/3,
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
                        "Save",
                        style: TextStyle(
                            color:AppColors.white.withOpacity(0.8),
                            fontSize: Get.height/50,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "Password",
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: Get.height / 40,
                          fontWeight:
                          FontWeight.bold)
                  ),




                ],
              ),
            ),


            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "Current Password"
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "New Password"
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: Get.height/50,left: Get.width/20,right:Get.width/20,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:  Container(
                      height: Get.height/17,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                      color: AppColors.gray.withOpacity(0.3)
                                  )
                              ),
                              hintText: "Confirm Password"
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),

            SizedBox(height:  Get.height/20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Utils.shortAlertToast("Password Updated");
                  },
                  child: Container(
                    height: Get.height/25,
                    width: Get.width/3,
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
                        "Save",
                        style: TextStyle(
                            color:AppColors.white.withOpacity(0.8),
                            fontSize: Get.height/50,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height:  Get.height/20,),
          ],
        ),
      )
    );
  }
}
