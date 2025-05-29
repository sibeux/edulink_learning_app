import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

const List<String> genderType = ['male', 'female', 'other'];

class GenderPick extends StatelessWidget {
  const GenderPick({super.key, required this.controller});

  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Gender',
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
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
        SizedBox(height: 15.h),
        Row(
          children: [
            GenderContainerType(index: 0, controller: controller),
            GenderContainerType(index: 1, controller: controller),
            GenderContainerType(index: 2, controller: controller),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

class GenderContainerType extends StatelessWidget {
  const GenderContainerType({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectedGender.value = genderType[index],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color:
                controller.selectedGender.value == genderType[index]
                    ? ColorPalette().primary
                    : HexColor('#E5ECFF'),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            genderType[index].capitalize!,
            style: TextStyle(
              color:
                  controller.selectedGender.value == genderType[index]
                      ? Colors.white
                      : Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
