import 'package:edulink_learning_app/controllers/auth_controller/otp_controller.dart';
import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/otp_button/otp_submit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../components/color_palette.dart';
import '../../../widgets/auth_widget/auth_button/otp_button/otp_input.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    final registerController = Get.find<RegisterController>();
    otpController.sendOTP(
      email:
          registerController.formData['emailRegister']!['text']
              .toString()
              .trim(),
      name:
          registerController.formData['nameRegister']!['text']
              .toString()
              .trim(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's activate\n your account!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: HexColor('#1A1A1A'),
            ),
          ),
          SizedBox(height: 26.h),
          Text(
            "Enter the 4 digit OTP code that\n was sent to your email",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: HexColor('#545454E').withValues(alpha: 0.93),
            ),
          ),
          SizedBox(height: 50.h),
          OtpInput(),
          Container(
            height: 50.h,
            width: 250.w,
            alignment: Alignment.topLeft,
            child: Obx(
              () =>
                  !otpController.isOtpValid.value
                      ? Text(
                        '*OTP is not valid',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red.withValues(alpha: 1),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                      : SizedBox(),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Didn't receive the code? ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#1A1A1A'),
                  ),
                ),
                TextSpan(
                  text: "Resend",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorPalette().primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
          Obx(
            () =>
                otpController.otpInput.value.length == 4
                    ? otpController.isLoading.value
                        ? AbsorbPointer(child: AuthButtonLoading())
                        : OtpSubmitEnable()
                    : AbsorbPointer(child: OtpSubmitDisable()),
          ),
        ],
      ),
    );
  }
}
