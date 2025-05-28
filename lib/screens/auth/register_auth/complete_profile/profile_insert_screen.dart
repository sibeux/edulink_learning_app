import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/complete_profile/button_save.dart';
import 'package:edulink_learning_app/widgets/complete_profile/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileInsertScreen extends StatelessWidget {
  const ProfileInsertScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: HexColor("#000000"),
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  UserPhoto(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        await Get.find<CompleteProfileController>()
                            .insertImage();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.w),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SaveEnable(),
          ],
        ),
      ),
    );
  }
}
