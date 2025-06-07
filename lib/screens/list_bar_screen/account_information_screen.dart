import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/listile_information.dart';
import 'package:edulink_learning_app/widgets/user_profile/PhotoUserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final completeProfileController = Get.put(CompleteProfileController());
    completeProfileController.assignCurrentDataForm();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPalette().primary,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          'Account Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              width: double.infinity,
              color: ColorPalette().primary,
              child: Column(
                children: [
                  Center(child: Photouserprofile()),
                  SizedBox(height: 15.h),
                  Obx(
                    () => Text(
                      userProfileController.userData[0].nameUser.capitalize!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#EEEEEE'),
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      userProfileController.userData[0].userEducation
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#FFD27F'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 40.h,
              color: ColorPalette().primary,
              child: Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Edit Information',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#535353'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  ListileInformation(
                    completeProfileController: completeProfileController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
