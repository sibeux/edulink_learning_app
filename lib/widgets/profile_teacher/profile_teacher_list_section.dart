import 'package:edulink_learning_app/controllers/profile_teacher_controller.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/sections/about_section.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/sections/available_date_section.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/sections/price_section.dart';
import 'package:edulink_learning_app/widgets/profile_teacher/sections/skills_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileTeacherListSection extends StatelessWidget {
  const ProfileTeacherListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileTeacherController = Get.find<ProfileTeacherController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          AboutSection(controller: profileTeacherController),
          SizedBox(height: 25.h),
          SkillsSection(controller: profileTeacherController),
          SizedBox(height: 25.h),
          AvailableDateSection(controller: profileTeacherController),
          SizedBox(height: 13.h),
          PriceSection(controller: profileTeacherController),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
