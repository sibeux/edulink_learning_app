import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/otp_controller.dart';
import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class OtpSubmitEnable extends StatelessWidget {
  const OtpSubmitEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'otp',
      buttonText: 'Continue',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        final otpController = Get.find<OtpController>();
        final registerController = Get.find<RegisterController>();

        otpController.verifyOtp(
          email:
              registerController.formData['emailRegister']!['text']
                  .toString()
                  .trim(),
          otp: otpController.otpInput.value,
        );
      },
    );
  }
}

class OtpSubmitDisable extends StatelessWidget {
  const OtpSubmitDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'otp',
      buttonText: 'Continue',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: true,
      onPressed: () {},
    );
  }
}
