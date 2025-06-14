import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/controllers/persistent_bar_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/account_information_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/teacher/profile_teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

List<String> _logoAssets = [
  'assets/images/screens/user-profile/user.png',
  'assets/images/screens/user-profile/profile.png',
  'assets/images/screens/user-profile/list.png',
  'assets/images/screens/user-profile/love.png',
  'assets/images/screens/user-profile/check.png',
  'assets/images/screens/user-profile/question.png',
  'assets/images/screens/user-profile/info.png',
];
List<String> _titles = [
  'Account Information',
  'Profile',
  'My Bookings',
  'Favorite Tutor',
  'Change Password',
  'FAQ',
  'About Us',
];
List<Function> _functions = [
  () {
    // Navigate to Account Information screen
    Get.to(
      () => const AccountInformationScreen(),
      transition: Transition.rightToLeft,
      popGesture: false,
      fullscreenDialog: true,
    );
  },
  () {
    // Navigate to Profile screen
    Get.to(
      () => const ProfileTeacherScreen(),
      transition: Transition.rightToLeft,
      popGesture: false,
      fullscreenDialog: true,
    );
  },
  () {
    // Navigate to Bookings screen
    Get.find<PersistentBarController>().controller.jumpToTab(1);
  },
  () {
    // Navigate to favorite tutor screen
    showToast('Feature coming soon!');
  },
  () {
    // Navigate to change password screen
    showToast('Feature coming soon!');
  },
  () {
    // Navigate to FAQ screen
    showToast('Feature coming soon!');
  },
  () {
    // Navigate to about us screen
    showToast('Feature coming soon!');
  },
];

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _titles.length; i++)
          if ((Get.find<UserProfileController>().userData[0].userActor ==
                      'student' &&
                  i != 1) ||
              (Get.find<UserProfileController>().userData[0].userActor ==
                  'tutor')) // Exclude 'Profile' for non-tutors
            ContainerProfileOptions(index: i),
      ],
    );
  }
}

class ContainerProfileOptions extends StatelessWidget {
  const ContainerProfileOptions({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: () {
          _functions[index]();
        },
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: HexColor('#E5ECFF'),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                _logoAssets[index],
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                _titles[index],
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorPalette().primary,
              size: 30.sp,
              weight: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
