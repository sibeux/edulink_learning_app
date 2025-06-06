import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/models/student_courses.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:edulink_learning_app/widgets/complete_profile/button_done.dart';
import 'package:edulink_learning_app/widgets/complete_profile/courses_pick_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CoursesInsertScreen extends StatelessWidget {
  const CoursesInsertScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    completeProfileController.assignCurrentDataForm();
    final key = completeProfileController.selectedEducationType.value;
    final courses = studentCourses[key.toUpperCase()]!;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            completeProfileController.isSendingDataLoading.value
                ? null
                : Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
        ),
        title: Text(
          "Courses",
          style: TextStyle(
            color: HexColor("#000000"),
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 268.w,
                height: 277.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/screens/complete_courses.png",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Discover your areas of interest\nin our courses',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#545454').withValues(alpha: 0.93),
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Wrap(
                  runSpacing: 20.h,
                  children:
                      courses.map((course) {
                        return CoursesPickContainer(
                          title: course,
                          controller: completeProfileController,
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 50.h),
              Obx(
                () =>
                    completeProfileController.isSendingDataLoading.value
                        ? AuthButtonLoading()
                        : completeProfileController.coursesList.isNotEmpty
                        ? DoneEnable()
                        : DoneDisable(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
