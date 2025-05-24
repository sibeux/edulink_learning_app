import 'package:edulink_learning_app/controllers/auth_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/color_palette.dart';

class LoginSubmitButtonEnable extends StatelessWidget {
  const LoginSubmitButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return AuthButton(
      authType: 'login',
      buttonText: 'Sign In',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        // userLoginController.generateJwtLogin(
        //   email: loginController.formData['emailLogin']!['text'].toString(),
        //   password:
        //       loginController.formData['passwordLogin']!['text'].toString(),
        // );
      },
    );
  }
}

class LoginSubmitButtonDisable extends StatelessWidget {
  const LoginSubmitButtonDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'login',
      buttonText: 'Sign In',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: false,
      onPressed: () {},
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.authType,
    required this.buttonText,
    required this.foreground,
    required this.background,
    required this.isEnable,
    required this.onPressed,
  });

  final String authType, buttonText;
  final Color foreground, background;
  final bool isEnable;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 248.w,
      height: 47.h,
      child: ElevatedButton(
        onPressed: () {
          if (isEnable) {
            onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: foreground,
          backgroundColor: background,
          elevation: 0, // Menghilangkan shadow
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 4.0.h),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AuthButtonLoading extends StatelessWidget {
  const AuthButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          // Do nothing
        },
        style: ElevatedButton.styleFrom(
          elevation: 0, // Menghilangkan shadow
          backgroundColor: HexColor('#fefffe'),
          splashFactory: InkRipple.splashFactory,
          side: BorderSide(
            color: ColorPalette().primary,
            strokeAlign: BorderSide.strokeAlignCenter,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: Center(
          child: Transform.scale(
            scale: 0.7,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorPalette().primary),
            ),
          ),
        ),
      ),
    );
  }
}
