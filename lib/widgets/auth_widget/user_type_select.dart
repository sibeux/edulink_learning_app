import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/color_palette.dart';

class UserTypeSelect extends StatelessWidget {
  const UserTypeSelect({
    super.key,
    required this.title,
    required this.index,
    required this.authController,
  });

  final String title;
  final int index;
  final dynamic authController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title,
          style: TextStyle(
            color:
                authController.indexUserType.value == index
                    ? ColorPalette().primary.withValues(alpha: 0.8)
                    : HexColor('#1A1A1A'),
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
