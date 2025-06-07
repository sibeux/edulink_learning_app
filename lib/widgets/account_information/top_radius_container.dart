import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopRadiusContainer extends StatelessWidget {
  const TopRadiusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40.h,
      child: OverflowBox(
        maxWidth: MediaQuery.of(context).size.width,
        child: Container(
          width: double.infinity,
          height: 40.h,
          color: ColorPalette().primary,
          child: Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
