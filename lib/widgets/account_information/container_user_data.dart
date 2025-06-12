import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/account_information_form_blprn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const Map<String, dynamic> formAttributes = {
  'nameProfile': {
    'keyboardType': TextInputType.name,
    'autoFillHints': AutofillHints.name,
    'invalidMessage': '*Name cannot contain numbers or special characters',
  },
  'emailProfile': {
    'keyboardType': TextInputType.emailAddress,
    'autoFillHints': AutofillHints.email,
    'invalidMessage': '*Invalid email format',
  },
  'numberProfile': {
    'keyboardType': TextInputType.phone,
    'autoFillHints': AutofillHints.telephoneNumber,
    'invalidMessage': '*Invalid phone number format',
  },
  'birthdayProfile': {
    'keyboardType': TextInputType.datetime,
    'autoFillHints': AutofillHints.birthdayDay,
    'invalidMessage': '*Invalid date format',
  },
  'cityProfile': {
    'keyboardType': TextInputType.text,
    'autoFillHints': AutofillHints.addressCity,
    'invalidMessage': '*City cannot contain numbers or special characters',
  },
  'countryProfile': {
    'keyboardType': TextInputType.text,
    'autoFillHints': AutofillHints.addressState,
    'invalidMessage': '*Country cannot contain numbers or special characters',
  },
  'addressProfile': {
    'keyboardType': TextInputType.streetAddress,
    'autoFillHints': AutofillHints.streetAddressLine1,
    'invalidMessage': '*Address cannot contain numbers or special characters',
  },
};

class ContainertileUserData extends StatelessWidget {
  const ContainertileUserData({
    super.key,
    required this.completeProfileController,
    required this.isHasInvalid,
    required this.isImmutable,
    required this.formType,
    required this.formtext,
    required this.needEditing,
  });

  final CompleteProfileController completeProfileController;
  final bool isHasInvalid, isImmutable, needEditing;
  final String formType, formtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              formtext.capitalize!,
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            isHasInvalid
                ? Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red.withValues(alpha: 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 5.h),
        AbsorbPointer(
          absorbing: !needEditing,
          child: AccountInformationFormBlprn(
            completeProfileController: Get.find<CompleteProfileController>(),
            isImmutable: isImmutable,
            needEditing: needEditing,
            formType: formType,
            formText: formtext,
            keyboardType:
                formAttributes[formType]['keyboardType'] as TextInputType,
            autoFillHints: formAttributes[formType]['autoFillHints'] as String,
          ),
        ),
        SizedBox(height: 5.h),
        isHasInvalid
            ? Obx(
              () =>
                  completeProfileController.formData[formType]!['text']
                              .toString()
                              .isNotEmpty ||
                          completeProfileController.currentType.value ==
                              formType
                      ? formType.toLowerCase().contains('name')
                          ? completeProfileController.getIsNameValid() &&
                                  completeProfileController
                                      .formData[formType]!['text']
                                      .toString()
                                      .isNotEmpty
                              ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  formAttributes[formType]['invalidMessage']
                                      as String,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.red.withValues(alpha: 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                              : SizedBox()
                          : SizedBox()
                      : SizedBox(),
            )
            : SizedBox(),
        SizedBox(height: 15.h),
      ],
    );
  }
}
