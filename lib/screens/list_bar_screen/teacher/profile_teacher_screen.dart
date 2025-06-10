import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/profile_teacher_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/profile_teacher_list_section.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/wrap_courses_profile_teacher.dart';
import 'package:edulink_learning_app/widgets/user_profile/photo_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileTeacherScreen extends StatelessWidget {
  const ProfileTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final completeProfileController = Get.put(CompleteProfileController());
    Get.put(ProfileTeacherController());
    completeProfileController.assignCurrentDataForm();
    completeProfileController.isNeedEditing.value = false;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (completeProfileController.isNeedEditing.value) {
                completeProfileController.isNeedEditing.value = false;
              } else {
                completeProfileController.isNeedEditing.value = true;
              }
            },
            child: Obx(
              () => Text(
                completeProfileController.isNeedEditing.value ? 'Done' : 'Edit',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 30.h,
                left: 20.w,
                right: 20.w,
                bottom: 30.h,
              ),
              decoration: BoxDecoration(
                color: ColorPalette().primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  Photouserprofile(),
                  SizedBox(height: 15.h),
                  Obx(
                    () => Text(
                      userProfileController.userData[0].nameUser,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#EEEEEE'),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  WrapCoursesProfileTeacher(
                    completeProfileController: completeProfileController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ProfileTeacherListSection(),
          ],
        ),
      ),
    );
  }
}
