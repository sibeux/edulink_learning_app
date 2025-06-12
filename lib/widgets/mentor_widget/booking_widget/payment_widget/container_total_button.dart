import 'package:edulink_learning_app/components/string_formatter.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/payment_widget/confirm_payment_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ContainerTotalButton extends StatelessWidget {
  const ContainerTotalButton({
    super.key,
    required this.bookingController,
    required this.mentor,
  });

  final BookingController bookingController;
  final ExploreMentor mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(23.r),
          topRight: Radius.circular(23.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: -8,
            blurRadius: 51,
            offset: Offset(11, 13), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harga',
                style: TextStyle(
                  color: HexColor('#646464'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                formatPrice(
                  (bookingController.durationBooking.value *
                          (int.tryParse(mentor.price ?? '0') ?? 0))
                      .toDouble(),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Spacer(),
          Obx(
            () => Flexible(
              flex: 2,
              child:
                  bookingController.isLoadingSendBooking.value
                      ? AbsorbPointer(child: AuthButtonLoading())
                      : ConfirmPaymentButton(
                          bookingController: bookingController,
                          mentor: mentor,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
