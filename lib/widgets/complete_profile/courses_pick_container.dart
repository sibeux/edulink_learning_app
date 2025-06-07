import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CoursesPickContainer extends StatelessWidget {
  const CoursesPickContainer({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap:
            () =>
                controller.coursesList.contains(title)
                    ? controller.coursesList.remove(title)
                    : controller.coursesList.add(title),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color:
                controller.coursesList.contains(title)
                    ? ColorPalette().primary
                    : HexColor('#E5ECFF'),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            title.capitalize!,
            style: TextStyle(
              color:
                  controller.coursesList.contains(title)
                      ? Colors.white
                      : Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
