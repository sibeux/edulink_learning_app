import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/banner_slider.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/guidance_rated_tutor.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/home_search_bar.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/interest_rated_categories.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/join_edulink_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 15.h,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logos/logo_splash.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.contain,
                    color: ColorPalette().primary,
                  ),
                  IconButton(
                    onPressed: () {
                      showToast('This feature is not available yet');
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      size: 32.sp,
                      color: ColorPalette().primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              HomeSearchBar(),
              SizedBox(height: 25.h),
              BannerSlider(),
              SizedBox(height: 30.h),
              GuidanceRatedTutor(),
              SizedBox(height: 30.h),
              InterestRatedCategories(),
              SizedBox(height: 30.h),
              JoinEdulinkContainer(),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {
                  showToast('This feature is not available yet');
                },
                child: Text(
                  'Need help?',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#9EB9FF'),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
