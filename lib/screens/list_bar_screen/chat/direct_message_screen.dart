import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/chat_controller/chat_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class DirectMessageScreen extends StatelessWidget {
  const DirectMessageScreen({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPalette().primary,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 40.h,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorPalette().primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(color: HexColor('#ffdb99')),
                      child: CachedNetworkImage(
                        imageUrl: booking.clientPhoto,
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
                  SizedBox(width: 20.w),
                  Text(
                    booking.clientName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: StreamBuilder<QuerySnapshot>(
                stream: Get.find<ChatController>().getMessagesFirebase(
                  senderID: Get.find<UserProfileController>().idUser.toString(),
                  receiverID:
                      Get.find<UserProfileController>().userData[0].userActor ==
                              'student'
                          ? booking.mentorId
                          : booking.studentId.toString(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No messages yet."));
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isSender =
                          msg['senderID'].toString() ==
                          Get.find<UserProfileController>().idUser.toString();
                      return Align(
                        alignment:
                            isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w,
                          ),
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color:
                                isSender
                                    ? ColorPalette().primary
                                    : HexColor('#E5ECFF'),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            msg['text'],
                            style: TextStyle(
                              color:
                                  isSender ? Colors.white : HexColor('#054BFF'),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          ChatInputField(
            chatController: Get.find<ChatController>(),
            booking: booking,
          ),
        ],
      ),
    );
  }
}

/// Widget untuk input chat
class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.chatController,
    required this.booking,
  });

  final ChatController chatController;
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Margin di sekitar kotak input
      margin: EdgeInsets.all(16.0.w),
      // Padding di dalam kotak input
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      // Dekorasi untuk membuat bentuk, warna, dan bayangan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 5.r,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tombol Ikon Tambah (+)
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.blue, size: 28.sp),
            onPressed: () {},
          ),
          SizedBox(width: 8.w), // Jarak kecil
          // Kolom Teks
          Expanded(
            child: TextField(
              controller: chatController.textEditingController,
              onChanged: (value) {
                chatController.message.value = value;
              },
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Membuat teks bisa multiline
              // Menghilangkan garis bawah pada TextField
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none, // Menghilangkan garis bawah
              ),
            ),
          ),
          // Tombol Ikon Kirim
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue, size: 28.sp),
            onPressed: () {
              final senderID = Get.find<UserProfileController>().idUser;
              final receiverID =
                  Get.find<UserProfileController>().userData[0].userActor ==
                          'student'
                      ? booking.mentorId
                      : booking.studentId;
              chatController.sendMessageFirebase(
                message: chatController.message.value,
                senderID: senderID.toString(),
                receiverID: receiverID.toString(),
              );
              chatController.textEditingController.clear();
              chatController.message.value = '';
            },
          ),
        ],
      ),
    );
  }
}
