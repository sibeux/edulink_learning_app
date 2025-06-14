import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/container_interest_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class InterestRatedCategories extends StatelessWidget {
  const InterestRatedCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Find your interests in our top-\nrated categories',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                // Handle "See All" action
                showToast('This feature is not available yet');
              },
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#BABABA').withValues(alpha: 0.93),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // Agar shadow tidak terpotong
            clipBehavior: Clip.none,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 3; i++)
                  ContainerInterestCategories(index: i),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
