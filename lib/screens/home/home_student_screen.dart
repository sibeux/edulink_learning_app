import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/banner_slider.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/home_search_bar.dart';
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      size: 32.sp,
                      color: ColorPalette().primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              HomeSearchBar(),
              SizedBox(height: 20.h),
              BannerSlider(),
              Container(
                
              ),
              ElevatedButton(
                onPressed: () async {
                  await Get.put(LogoutController()).logout();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
