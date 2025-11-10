import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/student/home_student_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/student/booking_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/chat/chat_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/student/mentor_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PersistentBarController extends GetxController {
  late PersistentTabController controller;
  int lastSelectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    controller = PersistentTabController(initialIndex: 0);
  }

  PersistentTabConfig buttonNavBar({
    required Widget screen,
    required String title,
    required IconData iconActive,
    required IconData iconInactive,
  }) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        icon: Icon(iconActive),
        inactiveIcon: Icon(iconInactive),
        title: title,
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        iconSize: 20.sp,
        activeForegroundColor: ColorPalette().primary,
        inactiveForegroundColor: HexColor('#bfbfbf'),
      ),
    );
  }

  // Item navigasi untuk tiap tab
  List<PersistentTabConfig> navBarsItems({required String actor}) {
    return actor == 'student'
        ? [
          buttonNavBar(
            screen: HomeStudentScreen(),
            title: 'Home',
            iconActive: Icons.home,
            iconInactive: Icons.home_outlined,
          ),
          buttonNavBar(
            screen: BookingScreen(),
            title: 'Booking',
            iconActive: Icons.description_rounded,
            iconInactive: Icons.description_outlined,
          ),
          buttonNavBar(
            screen: MentorScreen(),
            title: 'Mentor',
            iconActive: Icons.search,
            iconInactive: Icons.search_outlined,
          ),
          buttonNavBar(
            screen: ChatScreen(),
            title: 'Chat',
            iconActive: Icons.chat_rounded,
            iconInactive: Icons.chat_outlined,
          ),
          buttonNavBar(
            screen: UserProfileScreen(),
            title: 'Profile',
            iconActive: Icons.person_2_rounded,
            iconInactive: Icons.person_2_outlined,
          ),
        ]
        : [
          buttonNavBar(
            // screen: HomeTeacherScreen(),
            screen: HomeStudentScreen(),
            title: 'Home',
            iconActive: Icons.home,
            iconInactive: Icons.home_outlined,
          ),
          buttonNavBar(
            screen: BookingScreen(),
            title: 'Booking',
            iconActive: Icons.description_rounded,
            iconInactive: Icons.description_outlined,
          ),
          buttonNavBar(
            screen: ChatScreen(),
            title: 'Chat',
            iconActive: Icons.chat_rounded,
            iconInactive: Icons.chat_outlined,
          ),
          buttonNavBar(
            screen: UserProfileScreen(),
            title: 'Profile',
            iconActive: Icons.person_2_rounded,
            iconInactive: Icons.person_2_outlined,
          ),
        ];
  }
}
