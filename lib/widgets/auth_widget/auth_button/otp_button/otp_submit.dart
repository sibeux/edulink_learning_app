import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/otp_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller/register_controller.dart';

class OtpSubmit extends StatelessWidget {
  const OtpSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'otp',
      buttonText: 'Continue',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        
      },
    );
  }
}
