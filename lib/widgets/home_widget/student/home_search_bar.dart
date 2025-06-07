import 'package:edulink_learning_app/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement search functionality here
        showToast('This feature is not available yet');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: HexColor('#D4D4D4'), width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 24.sp,
              color: HexColor('#545454').withValues(alpha: 0.93),
            ),
            SizedBox(width: 12.w),
            Text(
              'Search Here',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: HexColor('#D4D4D4'),
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/logos/filter_alt.png',
              width: 24.w,
              height: 24.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
