import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ContainerOrderDetailPayment extends StatelessWidget {
  const ContainerOrderDetailPayment({
    super.key,
    required this.bookingController,
  });

  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    final UserProfileController userProfileController =
        Get.find<UserProfileController>();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h, left: 30.w, right: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Detail',
              style: TextStyle(
                color: HexColor('#1A1A1A'),
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15.h),
            TextitleDetailOrder(
              title: 'Name',
              value: userProfileController.userData[0].nameUser.capitalize!,
            ),
            SizedBox(height: 15.h),
            TextitleDetailOrder(
              title: 'Email',
              value: userProfileController.userData[0].emailuser,
            ),
            SizedBox(height: 15.h),
            TextitleDetailOrder(
              title: 'Contact',
              value: userProfileController.userData[0].userPhone,
            ),
            SizedBox(height: 15.h),
            TextitleDetailOrder(
              title: 'Duration',
              value:
                  '${bookingController.durationBooking.value.toString()} hour(s)',
            ),
            SizedBox(height: 15.h),
            TextitleDetailOrder(title: 'Payment Method', value: 'QRIS'),
          ],
        ),
      ),
    );
  }
}

class TextitleDetailOrder extends StatelessWidget {
  const TextitleDetailOrder({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: HexColor('#1A1A1A'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: HexColor('#646464'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
