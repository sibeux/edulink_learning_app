import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/screens/auth/register_auth/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class VerifsuccessScreen extends StatelessWidget {
  const VerifsuccessScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 268.w,
                height: 277.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/screens/verifsuccess.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 56.h),
              Text(
                "Successful Verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                "Your account has been\n verified successfully, please\n completed your profile",
                textAlign: TextAlign.center,
                maxLines: 4,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: HexColor("#000000"),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 115.h),
              SizedBox(
                width: 248.w,
                height: 47.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(
                      () => CompleteProfileScreen(
                        actor: actor,
                      ),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      popGesture: false,
                      fullscreenDialog: true,
                    );
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
                    child: Text(
                      "Next",
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
      ),
    );
  }
}
