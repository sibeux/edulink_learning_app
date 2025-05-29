import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BirthdayPicker extends StatelessWidget {
  const BirthdayPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hari
          SizedBox(
            width: 100.w,
            height: 300.h,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 40.h,
              magnification: 1.2,
              squeeze: 1.15,
              useMagnifier: true,
              scrollController: controller.dayController,
              onSelectedItemChanged: (index) {
                controller.selectedDay.value = index + 1;
              },
              diameterRatio: 1.2,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Colors.grey.withValues(alpha: 0.1),
              ),
              children: List.generate(
                31,
                (index) => Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ),
          // Bulan
          SizedBox(
            width: 120.w,
            height: 300.h,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 40.h,
              magnification: 1.2,
              squeeze: 1.15,
              useMagnifier: true,
              scrollController: controller.monthController,
              onSelectedItemChanged: (index) {
                controller.selectedMonth.value = index + 1;
              },
              diameterRatio: 1.2,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Colors.grey.withValues(alpha: 0.1),
              ),
              children: List.generate(
                controller.months.length,
                (index) => Center(
                  child: Text(
                    controller.months[index].toString(),
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ),
          // Tahun
          SizedBox(
            width: 100.w,
            height: 300.h,
            child: CupertinoPicker(
              looping: true,
              itemExtent: 40.h,
              magnification: 1.2,
              squeeze: 1.15,
              useMagnifier: true,
              scrollController: controller.yearController,
              onSelectedItemChanged: (index) {
                controller.selectedYear.value = controller.years[index];
              },
              diameterRatio: 1.2,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Colors.grey.withValues(alpha: 0.1),
              ),
              children: List.generate(
                controller.years.length,
                (index) => Center(
                  child: Text(
                    controller.years[index].toString(),
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
