import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../components/color_palette.dart';

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
