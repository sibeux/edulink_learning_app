import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/booking_type_select.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/explore_tutor_button.dart';
import 'package:edulink_learning_app/widgets/mentor_widget/booking_widget/ongoing_book_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BookingController bookingController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    bookingController = Get.put(BookingController());

    // Set initial index for the controller
    bookingController.changeIndexBookingType(0);

    // Add listener to sync TabController with BookingController
    _tabController.addListener(() {
      // Check if the index is changing to avoid unnecessary updates
      if (_tabController.indexIsChanging) {
        bookingController.changeIndexBookingType(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // It's good practice to remove the controller from GetX when the widget is disposed
    // if it's only used here.
    Get.delete<BookingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        toolbarHeight: 80.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Bookings',
              style: TextStyle(
                color: HexColor('#1A1A1A'),
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Check your bookings information here',
              style: TextStyle(
                color: HexColor(
                  '#6E6E6E',
                ).withValues(alpha: 0.93), // Using withOpacity for clarity
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TabBar(
              controller: _tabController,
              indicatorColor: ColorPalette().primary,
              labelColor: ColorPalette().primary,
              dividerColor: Colors.transparent,
              indicatorWeight: 4,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: BookingTypeSelect(
                    title: 'Upcoming',
                    index: 0,
                    bookingController: bookingController,
                  ),
                ),
                Tab(
                  child: BookingTypeSelect(
                    title: 'Ongoing',
                    index: 1,
                    bookingController: bookingController,
                  ),
                ),
                Tab(
                  child: BookingTypeSelect(
                    title: 'Done',
                    index: 2,
                    bookingController: bookingController,
                  ),
                ),
              ],
            ),
          ),
          // Use Expanded to make TabBarView fill the remaining space
          Expanded(
            child: Obx(
              () => TabBarView(
                controller: _tabController,
                // Each tab will display the same empty view for now.
                // You can replace these with different widgets for each tab.
                children: [
                  _buildEmptyBookingView(),
                  bookingController.isLoadingGetBooking.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: ColorPalette().primary,
                        ),
                      )
                      : bookingController.ongoingBookingList.isEmpty
                      ? _buildEmptyBookingView()
                      : ListView.builder(
                        itemCount:
                            bookingController.ongoingBookingList.length + 1,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? SizedBox(height: 20.h)
                              : OngoingBookContainer(
                                bookingController: bookingController,
                                index: index - 1,
                              );
                        },
                      ),
                  _buildEmptyBookingView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// A widget that displays the centered "Find a Tutor" content.
  Widget _buildEmptyBookingView() {
    // Center widget now works correctly because its parent (TabBarView > Expanded)
    // has a defined height.
    return Center(
      // A SingleChildScrollView is added here in case the content
      // overflows on smaller screens.
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 268.w,
              height: 277.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/screens/find_tutor.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Find a Tutor',
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'No upcoming bookings yet, but don\'t worry! Start your mentoring journey today and benefit from personalized guidance',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor('#BABABA').withValues(alpha: 0.93),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 65.h),
            const ExploreTutorButton(),
          ],
        ),
      ),
    );
  }
}
