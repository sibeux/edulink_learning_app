import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SaveEnable extends StatelessWidget {
  const SaveEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'save',
      buttonText: 'Save',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        await Get.find<CompleteProfileController>().sendChangeProfileData();
      },
    );
  }
}

class SaveDisable extends StatelessWidget {
  const SaveDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'save',
      buttonText: 'Save',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: true,
      onPressed: () {},
    );
  }
}
