import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class JoinEdulinkContainer extends StatelessWidget {
  const JoinEdulinkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
      decoration: BoxDecoration(
        color: HexColor('#E5ECFF'),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/screens/part-edulink.png',
            width: 115.w,
            height: 105.h,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register now and be\na part of EduLink',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorPalette().primary,
                  ),
                ),
                SizedBox(height: 12.h),
                ButtonStartPartEdulink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonStartPartEdulink extends StatelessWidget {
  const ButtonStartPartEdulink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: AuthButton(
        authType: 'start',
        buttonText: 'Start',
        foreground: Colors.white,
        background: ColorPalette().primary,
        isEnable: true,
        onPressed: () {
          showToast('This feature is not available yet');
        },
      ),
    );
  }
}
