import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 16.w),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: HexColor("#3A71FF"),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 268.w,
              height: 277.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/screens/onboarding_1.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 56.h),
            Text(
              'Welcome to EduLink',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: HexColor("#3A71FF"),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Engage with interactive lessons,\n quizzes, and assignments to\n deepen your understanding.",
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: 14.sp,
                color: HexColor("#000000"),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 46.h),
            SmoothPageIndicator(
              controller: PageController(),
              count: 3,
              effect: ScrollingDotsEffect(
                activeDotColor: HexColor("#3A71FF"),
                dotColor: HexColor("#E5ECFF"),
                dotHeight: 4.h,
                dotWidth: 4.w,
                spacing: 6.w,
              ),
            ),
            SizedBox(height: 67.h),
            SizedBox(
              width: 248.w,
              height: 47.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: HexColor("#3A71FF"),
                  elevation: 0, // Menghilangkan shadow
                  splashFactory: InkRipple.splashFactory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                    vertical: 4.0.h,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
