import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ButtonBookEnable extends StatelessWidget {
  const ButtonBookEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: AuthButton(
        authType: 'book',
        buttonText: 'Book',
        foreground: Colors.white,
        background: ColorPalette().primary,
        isEnable: true,
        onPressed: () {},
      ),
    );
  }
}

class ButtonBookDisable extends StatelessWidget {
  const ButtonBookDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: AuthButton(
        authType: 'book',
        buttonText: 'Book',
        foreground: HexColor('#BABABA'),
        background: HexColor('#EEEEEE'),
        isEnable: false,
        onPressed: () {},
      ),
    );
  }
}
