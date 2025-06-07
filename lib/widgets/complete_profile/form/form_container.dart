import 'package:edulink_learning_app/widgets/complete_profile/form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/color_palette.dart';
import '../../../controllers/complete_profile_controller.dart';

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

class FormContainer extends StatelessWidget {
  const FormContainer({
    super.key,
    required this.completeProfileController,
    required this.isHasInvalid,
    required this.formType,
    required this.formtext,
    this.isImmutable = false,
  });

  final CompleteProfileController completeProfileController;
  final bool isHasInvalid, isImmutable;
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
        SizedBox(height: 7.h),
        CompleteProfileFormBlueprint(
          completeProfileController: Get.find<CompleteProfileController>(),
          isImmutable: isImmutable,
          formType: formType,
          formText: formtext,
          keyboardType:
              formAttributes[formType]['keyboardType'] as TextInputType,
          autoFillHints: formAttributes[formType]['autoFillHints'] as String,
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
