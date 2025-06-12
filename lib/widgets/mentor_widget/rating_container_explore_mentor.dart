import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class RatingContainerExploreMentor extends StatelessWidget {
  const RatingContainerExploreMentor({
    super.key,
    required this.mentor,
  });

  final ExploreMentor mentor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 2.h,
          ),
          decoration: BoxDecoration(
            color: HexColor('#E5ECFF'),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: ColorPalette().primary,
                size: 12.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                mentor.name.contains('b') ? '4.8' : '4.5',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette().primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
