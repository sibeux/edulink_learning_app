import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:edulink_learning_app/widgets/complete_profile/button_save.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/modal_birthday.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/education_pick.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/gender_pick.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/teacher/courses_picker.dart';
import 'package:edulink_learning_app/widgets/complete_profile/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../widgets/complete_profile/form/form_container.dart';

class ProfileInsertScreen extends StatelessWidget {
  const ProfileInsertScreen({super.key, required this.actor});

  final String actor;

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    completeProfileController.assignCurrentDataForm();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            completeProfileController.isSendingDataLoading.value
                ? null
                : Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: HexColor("#000000"),
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      UserPhoto(),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await Get.find<CompleteProfileController>()
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
                      ),
                    ],
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      margin: EdgeInsets.only(
                        top: 10.h,
                        bottom: 30.h,
                        left: 50.w,
                        right: 50.w,
                      ),
                      decoration: BoxDecoration(
                        color:
                            completeProfileController.isImageFileTooLarge.value
                                ? const Color.fromARGB(255, 254, 231, 234)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child:
                          completeProfileController.isImageFileTooLarge.value
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormContainer(
                    isHasInvalid: true,
                    formType: 'nameProfile',
                    formtext: 'full name',
                    completeProfileController: completeProfileController,
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: FormContainer(
                      isHasInvalid: true,
                      isImmutable: true,
                      formType: 'emailProfile',
                      formtext: 'email',
                      completeProfileController: completeProfileController,
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: FormContainer(
                      isHasInvalid: true,
                      isImmutable: true,
                      formType: 'numberProfile',
                      formtext: 'phone number',
                      completeProfileController: completeProfileController,
                    ),
                  ),
                  if (actor == 'tutor')
                    CoursesPicker(
                      completeProfileController: completeProfileController,
                    ),
                  GenderPick(controller: completeProfileController),
                  GestureDetector(
                    onTap: () {
                      birthdayPickModal(
                        context,
                        controller: completeProfileController,
                      );
                    },
                    child: AbsorbPointer(
                      absorbing: true,
                      child: FormContainer(
                        isHasInvalid: false,
                        formType: 'birthdayProfile',
                        formtext: 'birth date',
                        completeProfileController: completeProfileController,
                      ),
                    ),
                  ),
                  if (actor == 'student')
                    EducationPick(controller: completeProfileController),
                  FormContainer(
                    isHasInvalid: true,
                    formType: 'cityProfile',
                    formtext: 'city',
                    completeProfileController: completeProfileController,
                  ),
                  FormContainer(
                    isHasInvalid: false,
                    formType: 'countryProfile',
                    formtext: 'country',
                    completeProfileController: completeProfileController,
                  ),
                  FormContainer(
                    isHasInvalid: false,
                    formType: 'addressProfile',
                    formtext: 'address line',
                    completeProfileController: completeProfileController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () =>
                  completeProfileController.isSendingDataLoading.value
                      ? AuthButtonLoading()
                      : completeProfileController.getIsAllDataValid()
                      ? SaveEnable()
                      : AbsorbPointer(absorbing: true, child: SaveDisable()),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
