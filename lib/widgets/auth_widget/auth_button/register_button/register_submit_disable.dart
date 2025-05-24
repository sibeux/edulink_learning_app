import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth_button.dart';

class RegisterSubmitButtonDisable extends StatelessWidget {
  const RegisterSubmitButtonDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'register',
      buttonText: 'Sign Up',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: false,
      onPressed: () {},
    );
  }
}
