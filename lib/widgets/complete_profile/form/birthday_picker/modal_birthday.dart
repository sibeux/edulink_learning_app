import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/button_birthday_pick.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/content_modal.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/title_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void birthdayPickModal(
  BuildContext context, {
  required CompleteProfileController controller,
}) {
  controller.setUpBirthDatePickerController();
  showDialog<bool>(
    barrierDismissible: true,
    context: context,
    barrierColor: Colors.black.withAlpha(100),
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: EdgeInsets.only(top: 0, bottom: 15.h),
        title: TitleModal(),
        content: ContentModal(),
        actions: <Widget>[SaveBirthdayPickEnable()],
      );
    },
  ).then((value) {
    if (value == true) {
      final TextEditingController birthdayController =
          controller.formData['birthdayProfile']?['controller']
              as TextEditingController;
      final day = controller.selectedDay.value.toString().padLeft(2, '0');
      final month = controller.selectedMonth.value.toString().padLeft(2, '0');
      final year = controller.selectedYear.value.toString();
      final String birthday = "$day/$month/$year";
      controller.formData['birthdayProfile'] = {
        'text': birthday,
        'type': 'birthdayProfile',
        'controller': birthdayController,
      };
      birthdayController.text = birthday;
      logInfo('Birthday selected: $birthday');
    }
  });
}
