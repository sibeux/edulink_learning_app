import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/complete_profile/courses_pick_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

const List<String> genderType = ['male', 'female', 'other'];

class CoursesPickerAccountInfo extends StatelessWidget {
  const CoursesPickerAccountInfo({
    super.key,
    required this.controller,
    required this.needEditing,
  });

  final CompleteProfileController controller;
  final bool needEditing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Interest',
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (needEditing)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red.withValues(alpha: 1),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        SizedBox(height: controller.coursesList.isEmpty ? 10.h : 15.h),
        Row(
          children: [
            if (controller.coursesList.isEmpty)
              Text(
                'No Set',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            if (!needEditing)
              for (var course in controller.coursesList)
                CoursesPickContainer(title: course, controller: controller),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
