import 'package:edulink_learning_app/controllers/persistent_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PersistentBarScreen extends StatelessWidget {
  const PersistentBarScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    final persistentBarController = Get.put(PersistentBarController());
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // Keluar dari aplikasi
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: PersistentTabView(
        tabs: persistentBarController.navBarsItems(actor: actor),
        controller: persistentBarController.controller,
        navBarBuilder: (p0) {
          return Style4BottomNavBar(
            navBarDecoration: NavBarDecoration(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.24),
                  spreadRadius: 1.r,
                  blurRadius: 19.r,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            navBarConfig: p0,
          );
        },
        hideNavigationBar: false,
        navBarOverlap: NavBarOverlap.none(), // Biar gak nutup widget lain
        screenTransitionAnimation: ScreenTransitionAnimation(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
        ),
        onTabChanged: (index) {
          persistentBarController.lastSelectedIndex = index;
        },
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: false, // Mengatur tombol back di Android
        resizeToAvoidBottomInset: true,
        stateManagement: true, // Untuk manajemen state dari tiap halaman
      ),
    );
  }
}
