import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const List<String> educationLevels = [
  'elementary',
  'junior high',
  'senior high',
];
const Map<String, List<String>> educationTypes = {
  'elementary': ['SD', 'MI'],
  'junior high': ['SMP', 'MTS'],
  'senior high': ['SMA', 'SMK', 'MA', 'MAK'],
};

class EducationPick extends StatelessWidget {
  const EducationPick({super.key, required this.controller});

  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Education Level',
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
            EducationContainerType(index: 0, controller: controller),
            SizedBox(width: 10.w),
            EducationContainerType(index: 1, controller: controller),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

class EducationContainerType extends StatelessWidget {
  const EducationContainerType({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            // Add Horizontal padding using menuItemStyleData.padding so it matches
            // the menu padding when button's width is not specified.
            contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: ColorPalette().primary, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color:
                    controller.selectedEducationLevel.value.isEmpty &&
                            index == 0
                        ? Colors.red.withValues(alpha: 1)
                        : controller.selectedEducationLevel.value.isEmpty &&
                            index == 1
                        ? Colors.grey
                        : controller.selectedEducationType.value.isEmpty &&
                            index == 1
                        ? Colors.red.withValues(alpha: 1)
                        : ColorPalette().primary,
                width: 1.w,
              ),
            ),
            // Add more decoration..
          ),
          hint: Text(
            index == 0 ? 'Level' : 'Type',
            style: TextStyle(fontSize: 14.sp),
          ),
          value:
              index == 0
                  ? controller.selectedEducationLevel.value.isEmpty
                      ? null
                      : controller.selectedEducationLevel.value
                  : controller.selectedEducationType.value.isEmpty
                  ? null
                  : controller.selectedEducationType.value,
          items:
              (index == 0
                      ? educationLevels
                      : educationTypes[controller
                              .selectedEducationLevel
                              .value] ??
                          [])
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        index == 0 ? item.capitalize! : item,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  )
                  .toList(),
          validator: (value) {
            if (value == null) {
              return index == 0
                  ? 'Please select education level'
                  : 'Please select education type';
            }
            return null;
          },
          onChanged: (value) {
            if (index == 0) {
              controller.selectedEducationLevel.value = value!;
              controller.selectedEducationType.value = '';
            } else {
              controller.selectedEducationType.value = value!;
            }
          },
          onSaved: (value) {
            // selectedValue = value.toString();
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 8.w),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
            iconSize: 24.sp,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
      ),
    );
  }
}
