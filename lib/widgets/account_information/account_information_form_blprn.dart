import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountInformationFormBlprn extends StatelessWidget {
  const AccountInformationFormBlprn({
    super.key,
    required this.formType,
    required this.keyboardType,
    required this.formText,
    required this.autoFillHints,
    required this.completeProfileController,
    required this.needEditing,
    this.isImmutable = false,
  });

  final String formType, formText, autoFillHints;
  final TextInputType keyboardType;
  final CompleteProfileController completeProfileController;
  final bool isImmutable, needEditing;

  @override
  Widget build(BuildContext context) {
    final controller =
        completeProfileController.formData[formType]?['controller'];
    return Obx(
      () => Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          controller: controller as TextEditingController?,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          enableSuggestions: true,
          autofillHints: [autoFillHints],
          keyboardType: keyboardType,
          obscureText: false,
          onChanged: (value) {
            completeProfileController.onChanged(value, formType);
          },
          onTap: () {
            completeProfileController.onTap(formType, true);
          },
          onTapOutside: (event) {
            completeProfileController.onTap(formType, false);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: TextStyle(
            color:
                !needEditing
                    ? HexColor('#545454').withValues(alpha: 0.93)
                    : isImmutable
                    ? Colors.grey
                    : HexColor('#1A1A1A'),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),

          decoration: InputDecoration(
            hintText: 'Not set',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
            isDense: true,
            fillColor: Colors.white,
            suffixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              // minHeight: 45.h,
            ),
            enabledBorder: underlineInputBorder(
              completeProfileController,
              formType,
              needEditing,
            ),
            focusedBorder: underlineInputBorder(
              completeProfileController,
              formType,
              needEditing,
            ),
          ),
        ),
      ),
    );
  }
}

UnderlineInputBorder underlineInputBorder(
  CompleteProfileController completeProfileController,
  String formType,
  bool needEditing,
) {
  final textValue =
      completeProfileController.formData[formType]?['text'].toString();
  final isCurrentType = completeProfileController.currentType.value == formType;

  return UnderlineInputBorder(
    borderSide: BorderSide(
      color:
          !needEditing
              ? Colors.transparent
              :
              // Cek apakah yang diklik adalah form saat ini atau form tidak kosong.
              (isCurrentType || textValue!.isNotEmpty)
              ?
              // Cek apakah form saat ini adalah full name
              formType.toLowerCase().contains('name')
                  // Cek apakah full name valid dan tidak kosong
                  ? completeProfileController.getIsNameValid() &&
                          textValue!.isNotEmpty
                      ? HexColor('#ff0000').withValues(alpha: 0.5)
                      : ColorPalette().primary.withValues(alpha: 0.5)
                  : ColorPalette().primary.withValues(alpha: 0.5)
              : HexColor('#BABABA').withValues(alpha: 0.93),
      width: 2.w,
    ),
  );
}
