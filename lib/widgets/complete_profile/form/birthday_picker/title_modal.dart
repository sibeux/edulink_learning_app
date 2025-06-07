import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TitleModal extends StatelessWidget {
  const TitleModal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();
    return Obx(
      () => Text(
        "${controller.selectedDay} ${controller.months[controller.selectedMonth.value - 1]} ${controller.selectedYear}",
        style: TextStyle(fontSize: 20.sp),
      ),
    );
  }
}
