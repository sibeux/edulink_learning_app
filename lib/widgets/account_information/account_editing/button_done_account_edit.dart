import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ButtonDoneAccountEdit extends StatelessWidget {
  const ButtonDoneAccountEdit({
    super.key,
    required this.completeProfileController,
  });

  final CompleteProfileController completeProfileController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Obx(
        () => InkWell(
          onTap: () async {
            if (!completeProfileController.getIsAllDataValid()) {
              return;
            }
            await completeProfileController.sendChangeProfileData(
              needBack: false,
            );
            completeProfileController.isNeedEditing.value = false;
          },
          child: Text(
            'Done',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color:
                  completeProfileController.getIsAllDataValid()
                      ? ColorPalette().primary
                      : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
