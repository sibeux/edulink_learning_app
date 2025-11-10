import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ContainerMentorPaymentInfo extends StatelessWidget {
  const ContainerMentorPaymentInfo({
    super.key,
    required this.mentor,
    required this.bookingController,
  });

  final ExploreMentor mentor;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    // Randomize int 1-3
    bookingController.durationBooking.value = Random().nextInt(3) + 1;
    // Get available days from bookingController
    List<String> available = bookingController.getAvailableDays(
      mentor.schedule ?? '',
    );
    // Randomize available days
    bookingController.dayBooking.value =
        available.isNotEmpty
            ? available[Random().nextInt(available.length)]
            : 'Monday';
    // Randomize hours 09:00 - 17:00
    final List<String> hours = [
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
    ];
    bookingController.hourBooking.value = hours[Random().nextInt(hours.length)];
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 35.0.h,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(color: HexColor('#ffdb99')),
                    child: CachedNetworkImage(
                      imageUrl: mentor.uriPhoto ?? '',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                      maxHeightDiskCache: 300,
                      maxWidthDiskCache: 300,
                      filterQuality: FilterQuality.medium,
                      placeholder:
                          (context, url) => Center(
                            child: SizedBox(
                              height: 70.h,
                              width: 70.w,
                              child: Image.asset(
                                'assets/images/screens/Edit Profile.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Center(
                            child: SizedBox(
                              height: 70.h,
                              width: 70.w,
                              child: Image.asset(
                                'assets/images/screens/Edit Profile.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mentor.name.contains('b') ? 'Math' : 'Science',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        ' • ${mentor.name.capitalize!}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#BABABA').withValues(alpha: 0.93),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: HexColor('#E5ECFF'),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${bookingController.durationBooking.value} Hour',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette().primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: HexColor('#E5ECFF'),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          bookingController.dayBooking.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette().primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: HexColor('#E5ECFF'),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '${bookingController.hourBooking.value} WIB',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette().primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
