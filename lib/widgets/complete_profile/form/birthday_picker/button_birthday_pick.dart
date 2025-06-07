import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';

class SaveBirthdayPickEnable extends StatelessWidget {
  const SaveBirthdayPickEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'saveBirthdayPick',
      buttonText: 'Select',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        // Must be use Navigator.pop to return a value from the dialog
        Navigator.of(context).pop(true);
      },
    );
  }
}
