import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:edulink_learning_app/widgets/complete_profile/button_save.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/modal_birthday.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/gender_pick.dart';
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
            Get.back();
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
              child: Stack(
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
                          border: Border.all(color: Colors.white, width: 3.w),
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
            ),
            SizedBox(height: 30.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormContainer(
                    isHasInvalid: true,
                    fomrType: 'nameProfile',
                    formtext: 'full name',
                    completeProfileController: completeProfileController,
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: FormContainer(
                      isHasInvalid: true,
                      isImmutable: true,
                      fomrType: 'emailProfile',
                      formtext: 'email',
                      completeProfileController: completeProfileController,
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: FormContainer(
                      isHasInvalid: true,
                      isImmutable: true,
                      fomrType: 'numberProfile',
                      formtext: 'phone number',
                      completeProfileController: completeProfileController,
                    ),
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
                        isHasInvalid: true,
                        fomrType: 'birthdayProfile',
                        formtext: 'birth date',
                        completeProfileController: completeProfileController,
                      ),
                    ),
                  ),
                  FormContainer(
                    isHasInvalid: false,
                    fomrType: 'cityProfile',
                    formtext: 'city',
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
          ],
        ),
      ),
    );
  }
}
