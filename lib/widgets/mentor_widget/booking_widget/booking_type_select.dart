import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class BookingTypeSelect extends StatelessWidget {
  const BookingTypeSelect({
    super.key,
    required this.title,
    required this.index,
    required this.bookingController,
  });

  final String title;
  final int index;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title,
          style: TextStyle(
            color:
                bookingController.indexBookingType.value == index
                    ? ColorPalette().primary.withValues(alpha: 0.8)
                    : HexColor('#1A1A1A'),
            fontWeight:
                bookingController.indexBookingType.value == index
                    ? FontWeight.w700
                    : FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
