// Widget yang berisi konten untuk ditampilkan di dalam bottom sheet
import 'package:edulink_learning_app/controllers/chat_controller/chat_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({
    super.key,
    required this.chatController,
    required this.needResetSession,
    required this.booking,
  });

  final ChatController chatController;
  final bool needResetSession;
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    // Padding ini penting agar keyboard tidak menutupi TextField
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            // Dekorasi untuk membuat sudut atas membulat dan memberi warna latar
            decoration: BoxDecoration(
              color: Color(0xFFf0f0f0), // Warna abu-abu muda
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0.r),
                topRight: Radius.circular(20.0.r),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                // `mainAxisSize.min` membuat tinggi Column sesuai dengan kontennya
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Label Teks
                  Text(
                    needResetSession
                        ? 'Ask EduBot anything about your school problems!'
                        : 'Answer the question from EduBot',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 2. Input Teks Panjang
                  TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: chatController.botTextEditingController,
                    onChanged: (value) {
                      chatController.botTextEditingController.text = value;
                    },
                    autofocus:
                        false, // Tidak langsung fokus ke text field saat muncul
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText:
                          needResetSession
                              ? 'Type your question here...'
                              : 'Type your answer here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 3. Tombol "Next"
                  Center(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () async {
                          // Hilangkan Keyboard
                          FocusScope.of(context).unfocus();
                          await chatController.sendPromptAnswerBot(
                            needResetSession: needResetSession,
                            booking: booking,
                            message:
                                chatController.botTextEditingController.text,
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                        child:
                            chatController.isLoadingSendBotAPI.value
                                ? Center(child: CircularProgressIndicator())
                                : needResetSession
                                ? const Text('Send Question')
                                : const Text('Send'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
