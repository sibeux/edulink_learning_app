import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'logout',
      buttonText: 'Logout',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        await Get.find<LogoutController>().logout();
      },
    );
  }
}
