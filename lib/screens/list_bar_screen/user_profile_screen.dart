import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/user_profile/photo_user_profile.dart';
import 'package:edulink_learning_app/widgets/user_profile/button_logout.dart';
import 'package:edulink_learning_app/widgets/user_profile/profile_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final logoutController = Get.put(LogoutController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorPalette().primary,
          appBar: AppBar(
            backgroundColor: ColorPalette().primary,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 20.h,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
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
                SizedBox(height: 55.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 35.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      ProfileOptions(),
                      SizedBox(height: 35.h),
                      ButtonLogout(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () =>
              logoutController.isLoggingOut.value ||
                      userProfileController.isLoading.value
                  ? const Opacity(
                    opacity: 0.8,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black,
                    ),
                  )
                  : const SizedBox(),
        ),
        Obx(
          () =>
              logoutController.isLoggingOut.value ||
                      userProfileController.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : const SizedBox(),
        ),
      ],
    );
  }
}
