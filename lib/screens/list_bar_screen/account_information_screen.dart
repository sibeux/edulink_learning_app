import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/account_editing/button_done_account_edit.dart';
import 'package:edulink_learning_app/widgets/account_information/account_editing/listile_account_editing.dart';
import 'package:edulink_learning_app/widgets/account_information/listile_information.dart';
import 'package:edulink_learning_app/widgets/account_information/photo_account_information.dart';
import 'package:edulink_learning_app/widgets/account_information/top_radius_container.dart';
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
    completeProfileController.isNeedEditing.value = false;
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
                      Center(
                        child: Stack(
                          children: [
                            PhotoAccountInformation(),
                            Obx(
                              () =>
                                  completeProfileController.isNeedEditing.value
                                      ? Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            await Get.find<
                                                  CompleteProfileController
                                                >()
                                                .insertImage();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 5.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorPalette().primary,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3.w,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 16.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                      : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Obx(
                        () => Text(
                          userProfileController.userData[0].nameUser,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      SizedBox(height: 10.h),
                      Obx(
                        () =>
                            completeProfileController.isNeedEditing.value
                                ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
                                  ),
                                  margin: EdgeInsets.only(
                                    left: 50.w,
                                    right: 50.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        completeProfileController
                                                .isImageFileTooLarge
                                                .value
                                            ? const Color.fromARGB(
                                              255,
                                              254,
                                              231,
                                              234,
                                            )
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child:
                                      completeProfileController
                                              .isImageFileTooLarge
                                              .value
                                          ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.info_outline,
                                                color: HexColor('#cd7a7d'),
                                                size: 15.sp,
                                              ),
                                              SizedBox(width: 5.h),
                                              Text(
                                                'Maksimal ukuran gambar 2 MB',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: HexColor('#cd7a7d'),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          )
                                          : const SizedBox(),
                                )
                                : const SizedBox(),
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
                                    actor:
                                        userProfileController
                                            .userData[0]
                                            .userActor,
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
                                    actor:
                                        userProfileController
                                            .userData[0]
                                            .userActor,
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
