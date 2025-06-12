import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

const List<String> genderType = ['male', 'female', 'other'];

class GenderPickerAccountInfo extends StatelessWidget {
  const GenderPickerAccountInfo({
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
              'Gender',
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
        SizedBox(height: 15.h),
        Row(
          children: [
            if (controller.selectedGender.value == genderType[0] || needEditing)
              GenderContainerTypeAccountInfo(
                index: 0,
                controller: controller,
                needEditing: needEditing,
              ),
            if (controller.selectedGender.value == genderType[1] || needEditing)
              GenderContainerTypeAccountInfo(
                index: 1,
                controller: controller,
                needEditing: needEditing,
              ),
            if (controller.selectedGender.value == genderType[2] || needEditing)
              GenderContainerTypeAccountInfo(
                index: 2,
                controller: controller,
                needEditing: needEditing,
              ),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

class GenderContainerTypeAccountInfo extends StatelessWidget {
  const GenderContainerTypeAccountInfo({
    super.key,
    required this.index,
    required this.controller,
    required this.needEditing,
  });

  final int index;
  final CompleteProfileController controller;
  final bool needEditing;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap:
            () =>
                !needEditing
                    ? null
                    : controller.selectedGender.value = genderType[index],
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
