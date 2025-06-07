import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/account_editing/button_done_account_edit.dart';
import 'package:edulink_learning_app/widgets/account_information/account_editing/listile_account_editing.dart';
import 'package:edulink_learning_app/widgets/account_information/listile_information.dart';
import 'package:edulink_learning_app/widgets/account_information/top_radius_container.dart';
import 'package:edulink_learning_app/widgets/user_profile/photo_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final completeProfileController = Get.put(CompleteProfileController());
    completeProfileController.assignCurrentDataForm();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorPalette().primary,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: ColorPalette().primary,
            surfaceTintColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            centerTitle: true,
            title: Text(
              'Account Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  color: ColorPalette().primary,
                  child: Column(
                    children: [
                      Center(child: Photouserprofile()),
                      SizedBox(height: 15.h),
                      Obx(
                        () => Text(
                          userProfileController
                              .userData[0]
                              .nameUser
                              .capitalize!,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#EEEEEE'),
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          userProfileController.userData[0].userEducation
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#FFD27F'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => AnimatedSwitcher(
                    // Durasi total untuk seluruh transisi (keluar + masuk)
                    duration: const Duration(milliseconds: 500),

                    // PENTING: Mengatur urutan animasi agar tidak tumpang tindih
                    switchOutCurve: const Interval(
                      0.0,
                      0.5,
                      curve: Curves.easeIn,
                    ),
                    switchInCurve: const Interval(
                      0.5,
                      1.0,
                      curve: Curves.easeOut,
                    ),

                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      // INILAH KUNCINYA: Atur widget untuk bergerak dari bawah layar
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(
                          0.0,
                          1.0,
                        ), // Mulai dari 100% di bawah layar
                        end: Offset.zero, // Selesai di posisi normal (0,0)
                      ).animate(
                        // Gunakan curve yang lebih halus untuk nuansa modal
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutCubic,
                        ),
                      );

                      return SlideTransition(
                        position: slideAnimation,
                        child: child,
                      );
                    },
                    child:
                        completeProfileController.isNeedEditing.value
                            ? Container(
                              key: ValueKey('editMode'),
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TopRadiusContainer(),
                                  ButtonDoneAccountEdit(
                                    completeProfileController:
                                        completeProfileController,
                                  ),
                                  SizedBox(height: 25.h),
                                  ListileAccountEditing(
                                    completeProfileController:
                                        completeProfileController,
                                  ),
                                ],
                              ),
                            )
                            : Container(
                              key: ValueKey('viewMode'),
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TopRadiusContainer(),
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        completeProfileController
                                            .isNeedEditing
                                            .value = true;
                                      },
                                      child: Text(
                                        'Edit Information',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor('#535353'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25.h),
                                  ListileInformation(
                                    completeProfileController:
                                        completeProfileController,
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (completeProfileController.isSendingDataLoading.value) {
            // Jika loading, tampilkan tumpukan overlay
            return Stack(
              children: [
                // Latar belakang semi-transparan yang memblokir klik
                ModalBarrier(
                  dismissible: false,
                  color: Colors.black.withValues(
                    alpha: 0.5,
                  ), // Warna bisa diatur di sini
                ),
                // Indikator loading di tengah
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ],
            );
          } else {
            // Jika tidak loading, jangan tampilkan apa-apa
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
