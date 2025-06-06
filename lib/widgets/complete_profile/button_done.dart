import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth_widget/auth_button/auth_button.dart';

class DoneEnable extends StatelessWidget {
  const DoneEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'done',
      buttonText: 'Done',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        await Get.find<CompleteProfileController>().sendChangeProfileData();
      },
    );
  }
}

class DoneDisable extends StatelessWidget {
  const DoneDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'done',
      buttonText: 'Done',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: true,
      onPressed: () {},
    );
  }
}
