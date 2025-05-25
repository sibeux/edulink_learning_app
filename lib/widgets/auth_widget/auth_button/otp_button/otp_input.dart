import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pinput.dart';

import '../../../../components/colorize_terminal.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: HexColor('#1A1A1A'),
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: HexColor('#EEEEEE'),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      width: 64.w,
      height: 68.h,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette().primary),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SizedBox(
      height: 68,
      width: double.infinity,
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) => logInfo(pin),
      ),
    );
  }
}
