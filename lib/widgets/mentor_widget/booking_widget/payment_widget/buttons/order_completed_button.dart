import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/persistent_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckBookStatusButton extends StatelessWidget {
  const CheckBookStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 47.h,
      child: ElevatedButton(
        onPressed: () {
          Get.find<PersistentBarController>().controller.jumpToTab(1);
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorPalette().primary,
          backgroundColor: Colors.white,
          elevation: 0, // Menghilangkan shadow
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
          child: Text(
            'Check Booking Status',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class GoToHomeScreen extends StatelessWidget {
  const GoToHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 47.h,
      child: ElevatedButton(
        onPressed: () {
          Get.find<PersistentBarController>().controller.jumpToTab(0);
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorPalette().primary,
          elevation: 0, // Menghilangkan shadow
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: Colors.white, width: 3.0.w),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
          child: Text(
            'Back to Home',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
