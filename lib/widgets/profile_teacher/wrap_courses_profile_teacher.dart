import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class WrapCoursesProfileTeacher extends StatelessWidget {
  const WrapCoursesProfileTeacher({
    super.key,
    required this.completeProfileController,
  });

  final CompleteProfileController completeProfileController;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.w, // Jarak horizontal antar Chip
      runSpacing: 6.h, // Jarak vertikal antar Chip
      children:
          completeProfileController.coursesList
              .map(
                (course) => Padding(
                  padding: EdgeInsets.only(
                    right: 6.w,
                  ), // Memberi jarak antar Chip
                  child: Chip(
                    label: Text(course.capitalize!),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    backgroundColor: HexColor('#FFC04D'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
              )
              .toList(),
    );
  }
}
