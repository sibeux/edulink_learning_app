import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/color_palette.dart';
import '../auth_button.dart';

class RegisterSubmitButtonEnable extends StatelessWidget {
  const RegisterSubmitButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<RegisterController>();

    return AuthButton(
      authType: 'register',
      buttonText: 'Sign Up',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        registerController.getCheckEmailPhone(
          email:
              registerController.formData['emailRegister']!['text']
                  .toString()
                  .trim(),
          phone:
              registerController.formData['numberRegister']!['text']
                  .toString()
                  .trim(),
        );
      },
    );
  }
}
