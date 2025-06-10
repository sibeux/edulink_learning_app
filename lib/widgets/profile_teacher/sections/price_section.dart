import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/components/shimmer.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/profile_teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key, required this.controller});

  final ProfileTeacherController controller;

  @override
  Widget build(BuildContext context) {
    final completeProfileController = Get.find<CompleteProfileController>();
    String formatPrice(double price) {
      if (price == 0) {
        return 'No Price Set';
      }
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp. ',
        decimalDigits: 0,
      );
      return formatter.format(price);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set Price',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: HexColor('#1A1A1A'),
              ),
            ),
            Obx(
              () => Opacity(
                opacity:
                    completeProfileController.isNeedEditing.value ? 1.0 : 0.0,
                child: GestureDetector(
                  onTap: () {
                    completeProfileController.isNeedEditing.value ? null : null;
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
                    child: Icon(Icons.edit, color: Colors.white, size: 14.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Obx(
          () =>
              controller.isLoadingFetchData.value
                  ? textShimmer(text: 'this is loading shimmer', size: 20)
                  : controller.teacherData[0].price == null
                  ? Text(
                    'No price available',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#545454').withValues(alpha: 0.93),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                  : Row(
                    children: [
                      Text(
                        formatPrice(controller.teacherData[0].price ?? 0.0),
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontStyle:
                              controller.teacherData[0].price == null
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                        ),
                      ),
                      Text(
                        ' / hour',
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}
