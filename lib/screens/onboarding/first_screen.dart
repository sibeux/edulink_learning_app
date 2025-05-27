import 'package:edulink_learning_app/controllers/onboarding_screen_controller.dart';
import 'package:edulink_learning_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/color_palette.dart';
import 'package:flutter/services.dart';

const titleString = [
  'Welcome to EduLink',
  "Learn where I am anytime",
  "Tutoring online made easier",
  "Study Online With Reliable Tutors",
];

const descriptionString = [
  'Engage with interactive lessons,\n quizzes, and assignments to\n deepen your understanding',
  'Stay motivated with personalized\n recommendations and learning\n resources tailored to your needs',
  'Get ready to unlock your full potential and\n achieve your learning objectives with our\n trusted tutors by your side',
  'Feel the convenience of online learning\n with trusted tutors who are ready to support\n your learning journey',
];

const imageString = [
  'assets/images/screens/onboarding_1.png',
  'assets/images/screens/onboarding_2.png',
  'assets/images/screens/onboarding_3.png',
  'assets/images/screens/onboarding_4.png',
];

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingScreenController = Get.put(OnboardingScreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: Obx(
          () =>
              onboardingScreenController.currentPageIndex.value != 0
                  ? Container(
                    margin: EdgeInsets.only(left: 16.w),
                    child: GestureDetector(
                      onTap: () {
                        onboardingScreenController.previousPage();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorPalette().primary,
                      ),
                    ),
                  )
                  : SizedBox(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Container(
                    key: ValueKey(
                      imageString[onboardingScreenController
                          .currentPageIndex
                          .value],
                    ),
                    width: 268.w,
                    height: 277.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imageString[onboardingScreenController
                              .currentPageIndex
                              .value],
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 56.h),
              Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    titleString[onboardingScreenController
                        .currentPageIndex
                        .value],
                    key: ValueKey(
                      titleString[onboardingScreenController
                          .currentPageIndex
                          .value],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette().primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Text(
                    descriptionString[onboardingScreenController
                        .currentPageIndex
                        .value],
                    key: ValueKey(
                      descriptionString[onboardingScreenController
                          .currentPageIndex
                          .value],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: HexColor("#000000"),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 46.h),
              Obx(
                () => Opacity(
                  opacity:
                      onboardingScreenController.currentPageIndex.value > 2
                          ? 0.0
                          : 1.0,
                  child: AnimatedSmoothIndicator(
                    activeIndex:
                        onboardingScreenController.currentPageIndex.value,
                    count: 3,
                    effect: ScrollingDotsEffect(
                      activeDotColor: ColorPalette().primary,
                      dotColor: HexColor("#E5ECFF"),
                      dotHeight: 4.h,
                      dotWidth: 4.w,
                      spacing: 6.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 67.h),
              SizedBox(
                width: 248.w,
                height: 47.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (onboardingScreenController.currentPageIndex.value > 2) {
                      Get.to(
                        () => LoginScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 300),
                        fullscreenDialog: true,
                        popGesture: false,
                      );
                    } else {
                      onboardingScreenController.nextPage();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorPalette().primary,
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
                    child: Obx(
                      () => Text(
                        onboardingScreenController.currentPageIndex.value > 2
                            ? "Login"
                            : "Next",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
