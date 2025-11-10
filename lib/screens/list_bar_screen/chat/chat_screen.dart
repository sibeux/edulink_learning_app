import 'package:cached_network_image/cached_network_image.dart';
import 'package:edulink_learning_app/components/string_formatter.dart';
import 'package:edulink_learning_app/controllers/chat_controller/chat_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/chat/direct_message_screen.dart';
import 'package:edulink_learning_app/widgets/home_widget/student/home_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    chatController.fetchRecentChats(Get.find<UserProfileController>().idUser);
    return Scaffold(
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
              'Chat',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            HomeSearchBar(),
            SizedBox(height: 20.h),
            Obx(
              () => Expanded(
                child:
                    chatController.isLoadingFetchingRecentChats.value
                        ? Center(child: CircularProgressIndicator())
                        : chatController.recentChats.isEmpty
                        ? Center(
                          child: Text(
                            'No recent chats found.',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemBuilder: (context, index) {
                            final recentChat =
                                chatController.recentChats[index];
                            return GestureDetector(
                              onTap: () {
                                final userController =
                                    Get.find<UserProfileController>();
                                final bool isStudent =
                                    userController.userData[0].userActor ==
                                    'student';
                                final studentId =
                                    isStudent
                                        ? userController.idUser
                                        : recentChat.peerId;
                                final Booking data = Booking(
                                  mentorId: recentChat.peerId,
                                  studentId: studentId,
                                  clientName: recentChat.fullname,
                                  clientPhoto: recentChat.uriPhoto,
                                  bookingId: '',
                                  status: '',
                                  price: '',
                                  day: '',
                                  time: '',
                                  duration: '',
                                );
                                Get.to(
                                  () {
                                    return DirectMessageScreen(booking: data);
                                  },
                                  transition: Transition.rightToLeftWithFade,
                                  fullscreenDialog: true,
                                  popGesture: false,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.w,
                                  vertical: 18.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      spreadRadius: -2.r,
                                      blurRadius: 16.r,
                                      offset: Offset(
                                        2,
                                        5,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: HexColor('#ffdb99'),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: recentChat.uriPhoto,
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                          maxHeightDiskCache: 300,
                                          maxWidthDiskCache: 300,
                                          filterQuality: FilterQuality.medium,
                                          placeholder:
                                              (context, url) => Center(
                                                child: SizedBox(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  child: Image.asset(
                                                    'assets/images/screens/Edit Profile.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                          errorWidget:
                                              (context, url, error) => Center(
                                                child: SizedBox(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  child: Image.asset(
                                                    'assets/images/screens/Edit Profile.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 18.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recentChat.fullname,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            recentChat.lastMessage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 18.w),
                                    Text(
                                      formatChatDate(
                                        recentChat.updatedAt.toString(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: chatController.recentChats.length,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
