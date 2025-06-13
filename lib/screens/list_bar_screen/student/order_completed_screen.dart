import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/payment_widget/buttons/order_completed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: (MediaQuery.of(context).size.width * 0.5).sp,
              color: Colors.white,
            ),
            SizedBox(height: 30),
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0.w),
              child: Text(
                'Your payment  was successful and your order is complete.\n\n\nWe haven\'t sent you an email as proof of delivery and provide purchase details.',
                maxLines: null,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            CheckBookStatusButton(),
            SizedBox(height: 20.h),
            GoToHomeScreen(),
          ],
        ),
      ),
    );
  }
}
