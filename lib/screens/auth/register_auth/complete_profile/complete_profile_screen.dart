import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/complete_profile/button_get_started.dart';
import 'package:edulink_learning_app/widgets/complete_profile/container_complete_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.put(CompleteProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 268.w,
                height: 277.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/screens/complete_profile.png",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              Text(
                'Complete your\n profile!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              ContainerCompleteProfile(index: 0, actor: actor),
              SizedBox(height: 15.h),
              ContainerCompleteProfile(index: 1, actor: actor),
              SizedBox(height: 50.h),
              Obx(
                () =>
                    actor == 'student'
                        ? completeProfileController
                                .profileStudentCompleted
                                .value
                            ? const GetStartedEnable()
                            : AbsorbPointer(child: const GetStartedDisable())
                        : const SizedBox(),
              ),
              SizedBox(height: 15.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'or',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ' Later',
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
