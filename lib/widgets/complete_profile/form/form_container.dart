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
};

class FormContainer extends StatelessWidget {
  const FormContainer({
    super.key,
    required this.completeProfileController,
    required this.isHasInvalid,
    required this.fomrType,
    required this.formtext,
    this.isImmutable = false,
  });

  final CompleteProfileController completeProfileController;
  final bool isHasInvalid, isImmutable;
  final String fomrType, formtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formtext.capitalize!,
          style: TextStyle(
            color: ColorPalette().primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 7.h),
        CompleteProfileFormBlueprint(
          completeProfileController: Get.find<CompleteProfileController>(),
          isImmutable: isImmutable,
          formType: fomrType,
          formText: formtext,
          keyboardType:
              formAttributes[fomrType]['keyboardType'] as TextInputType,
          autoFillHints: formAttributes[fomrType]['autoFillHints'] as String,
        ),
        SizedBox(height: 5.h),
        Obx(
          () =>
              isHasInvalid && (completeProfileController.getIsNameValid())
                  ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formAttributes[fomrType]['invalidMessage'] as String,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red.withValues(alpha: 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  : SizedBox(),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
