import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/payment_widget/container_mentor_payment_info.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/payment_widget/container_order_detail_payment.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/payment_widget/buttons/container_total_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.mentor});

  final ExploreMentor mentor;

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find<BookingController>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new, color: ColorPalette().primary),
            ),
            centerTitle: true,
            title: Text(
              'Payment',
              style: TextStyle(
                color: HexColor('#1A1A1A'),
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 60.w,
                          vertical: 20.h,
                        ),
                        child: Image.asset(
                          'assets/images/screens/dummy_progress_bar.png',
                        ),
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 2),
                      SizedBox(height: 30.h),
                      ContainerMentorPaymentInfo(
                        mentor: mentor,
                        bookingController: bookingController,
                      ),
                      SizedBox(height: 25.h),
                      ContainerOrderDetailPayment(
                        bookingController: bookingController,
                      ),
                    ],
                  ),
                ),
              ),
              ContainerTotalButton(
                bookingController: bookingController,
                mentor: mentor,
              ),
            ],
          ),
        ),
        Obx(
          () =>
              bookingController.isLoadingSendBooking.value
                  ? ModalBarrier(dismissible: false, color: Colors.transparent)
                  : const SizedBox(),
        ),
      ],
    );
  }
}
