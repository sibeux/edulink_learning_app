import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/login_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        loginController.generateJwtLogin(
          email: loginController.formData['emailLogin']!['text'].toString(),
          password:
              loginController.formData['passwordLogin']!['text'].toString(),
          actor: loginController.indexUserType.value == 0
              ? 'student'
              : 'tutor',
        );
      },
    );
  }
}
