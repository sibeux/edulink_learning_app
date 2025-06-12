import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/home_search_bar.dart';
import 'package:edulink_learning_app/widgets/mentor/listile_explore_mentor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MentorScreen extends StatelessWidget {
  const MentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingController = Get.put(BookingController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 15.h,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Find Your Favorite Mentor',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.h),
                HomeSearchBar(),
                SizedBox(height: 20.h),
                Expanded(
                  child: Obx(
                    () =>
                        bookingController.exploreMentorList.isEmpty
                            ? Center(
                              child: Text(
                                'No mentors found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemBuilder: (context, index) {
                                return ListileExploreMentor(
                                  mentor:
                                      bookingController
                                          .exploreMentorList[index],
                                );
                              },
                              itemCount:
                                  bookingController.exploreMentorList.length,
                              shrinkWrap: true,
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () =>
              bookingController.isLoadingFetchExploreMentors.value
                  ? const Opacity(
                    opacity: 0.8,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black,
                    ),
                  )
                  : const SizedBox(),
        ),
        Obx(
          () =>
              bookingController.isLoadingFetchExploreMentors.value
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : const SizedBox(),
        ),
      ],
    );
  }
}
