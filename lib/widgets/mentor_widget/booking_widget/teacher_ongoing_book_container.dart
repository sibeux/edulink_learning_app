import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/button_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class TeacherOngoingBookContainer extends StatelessWidget {
  const TeacherOngoingBookContainer({
    super.key,
    required this.bookingController,
    required this.index,
  });

  final BookingController bookingController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor('#E5ECFF'),
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                bookingController.ongoingBookingList[index].mentorName.contains(
                      'b',
                    )
                    ? 'Math'
                    : 'Science',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                ' • ${bookingController.ongoingBookingList[index].mentorName.capitalize!}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#6E6E6E').withValues(alpha: 0.93),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_outlined,
                size: 12.sp,
                color: HexColor('##545454').withValues(alpha: 0.93),
              ),
              SizedBox(width: 5.w),
              Text(
                'Duration: ${bookingController.ongoingBookingList[index].duration} Hour(s)',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor('##545454').withValues(alpha: 0.93),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  bookingController.ongoingBookingList[index].day,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#1A1A1A'),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${bookingController.ongoingBookingList[index].time} WIB',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#1A1A1A'),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(color: HexColor('#ffdb99')),
                  child: CachedNetworkImage(
                    imageUrl:
                        bookingController.ongoingBookingList[index].mentorPhoto,
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                    maxHeightDiskCache: 300,
                    maxWidthDiskCache: 300,
                    filterQuality: FilterQuality.medium,
                    placeholder:
                        (context, url) => Center(
                          child: SizedBox(
                            height: 30.h,
                            width: 30.w,
                            child: Image.asset(
                              'assets/images/screens/Edit Profile.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Center(
                          child: SizedBox(
                            height: 30.h,
                            width: 30.w,
                            child: Image.asset(
                              'assets/images/screens/Edit Profile.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(color: Colors.white, thickness: 2),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Click finish to end the class for this booking',
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#6B94FF'),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(flex: 1, child: ButtonFinishBooking(
                bookingController: bookingController,
                booking: bookingController.ongoingBookingList[index],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
