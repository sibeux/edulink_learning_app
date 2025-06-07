import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/screens/persistent_bar_screen.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class GetStartedEnable extends StatelessWidget {
  const GetStartedEnable({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'getStarted',
      buttonText: 'Get Started',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        Get.off(
          () => PersistentBarScreen(
            actor: actor,
          ),
          transition: Transition.native,
          fullscreenDialog: true,
          popGesture: false,
        );
      },
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
