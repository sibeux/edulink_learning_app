import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/persistent_bar_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreTutorButton extends StatelessWidget {
  const ExploreTutorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'exploreTutor',
      buttonText: 'Explore Tutors',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        Get.find<PersistentBarController>().controller.jumpToTab(2);
      },
    );
  }
}
