import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GetStartedEnable extends StatelessWidget {
  const GetStartedEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'getStarted',
      buttonText: 'Get Started',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {},
    );
  }
}

class GetStartedDisable extends StatelessWidget {
  const GetStartedDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'getStarted',
      buttonText: 'Get Started',
      foreground: HexColor('#BABABA'),
      background: HexColor('#EEEEEE'),
      isEnable: true,
      onPressed: () {},
    );
  }
}
