import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
