import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:edulink_learning_app/models/recent_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  var textEditingController = TextEditingController();
  var botTextEditingController = TextEditingController();
  RxString message = ''.obs;

  var idMessageBotToReply = ''.obs;

  var isLoadingFetchingRecentChats = false.obs;
  var isLoadingSendBotAPI = false.obs;
  var recentChatHasBeenFetched = false.obs;

  RxList<RecentChat> recentChats = <RecentChat>[].obs;

  Future<void> sendPromptAnswerBot({
    required bool needResetSession,
    required String message,
    required Booking
    booking, // Booking model yang berisi informasi mentor dan student
  }) async {
    isLoadingSendBotAPI.value = true;

    final senderID = Get.find<UserProfileController>().idUser;
    final receiverID =
        Get.find<UserProfileController>().userData[0].userActor == 'student'
            ? booking.mentorId
            : booking.studentId;

    await sendMessageToParticipants(
      message: message,
      senderID: senderID.toString(),
      participants: [
        senderID.toString(),
        receiverID.toString(),
        'cybot', // tambahkan bot ke dalam peserta
      ],
    );

    final urlResetToken = Uri.parse(
      'https://chatbot-edulink-production.up.railway.app/reset_session',
    );
    final urlSendPrompt = Uri.parse(
      'https://chatbot-edulink-production.up.railway.app/chat',
    );

    final String sessionId = "${senderID}_$receiverID";

    if (needResetSession) {
      // Reset session token untuk user
      await http.post(
        urlResetToken,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': sessionId}),
      );
    }

    final responseSendPrompt = await http.post(
      urlSendPrompt,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': sessionId, 'message': message}),
    );

    if (responseSendPrompt.statusCode == 200) {
      final data = jsonDecode(responseSendPrompt.body);
      logSuccess('Message sent to bot successfully');
      logInfo('Bot response: ${data['response']}');
      final botMessage = data['response'] as String;

      // Bot created the message
      sendMessageToParticipants(
        message: botMessage,
        senderID: 'cybot', // ID bot
        participants: [
          senderID.toString(),
          receiverID.toString(),
          'cybot', // tambahkan bot ke dalam peserta
        ],
      );
    } else {
      logError('Failed to send message to bot: ${responseSendPrompt.body}');
    }

    isLoadingSendBotAPI.value = false;
  }

  Future<void> sendMessageToParticipants({
    required String message,
    required String senderID,
    required List<String> participants, // termasuk sender + receiver + bot
  }) async {
    final sortedParticipants = [...participants]..sort();
    final firestore = FirebaseFirestore.instance;

    // Cek apakah chatroom grup sudah ada
    final querySnapshot =
        await firestore
            .collection('chatrooms')
            .where('members', arrayContainsAny: sortedParticipants)
            .get();

    String? chatRoomID;

    for (final doc in querySnapshot.docs) {
      final members = List<String>.from(doc['members']);
      members.sort();

      if (members.length == sortedParticipants.length &&
          const ListEquality().equals(members, sortedParticipants)) {
        chatRoomID = doc.id;
        break;
      }
    }

    // Kalau belum ada → buat baru
    if (chatRoomID == null) {
      chatRoomID = 'chat_${sortedParticipants.join("_")}';

      await firestore.collection('chatrooms').doc(chatRoomID).set({
        'chatRoomID': chatRoomID,
        'members': sortedParticipants,
        'createdAt': Timestamp.now(),
        'isGroup': sortedParticipants.length > 2,
      });
    }

    // Kirim pesan ke chatroom tersebut
    await firestore.collection('chat').add({
      'messageID': const Uuid().v4(),
      'chatRoomID': chatRoomID,
      'senderID': senderID,
      'receiverID': null, // biar netral, karena ini group
      'text': message,
      'createdAt': Timestamp.now(),
    });

    // Tentukan 1 receiver utama (bukan bot)
    final realReceiverID = participants.firstWhere(
      (id) => id != senderID && id != 'cybot',
    );

    final realSenderID = participants.firstWhere(
      (id) => id != realReceiverID && id != 'cybot',
    );

    // Kirim ke SQL
    sendRecentChat(
      userId: realSenderID,
      peerId: realReceiverID,
      lastMessage: message,
    );
    sendRecentChat(
      userId: realReceiverID,
      peerId: realSenderID,
      lastMessage: message,
    );

    fetchRecentChats(Get.find<UserProfileController>().idUser);
  }

  String generateGroupChatRoomID(List<String> participants) {
    final sorted = [...participants]..sort();
    return 'chat_${sorted.join("_")}';
  }

  Stream<QuerySnapshot> getMessagesGroupFirebase({
    required List<String> participants,
  }) {
    final chatRoomID = generateGroupChatRoomID(participants);

    return FirebaseFirestore.instance
        .collection('chat')
        .where('chatRoomID', isEqualTo: chatRoomID)
        .orderBy('createdAt')
        .snapshots();
  }

  // void sendMessageFirebase({
  //   required String message,
  //   required String senderID,
  //   required String receiverID,
  // }) {
  //   final chatRoomID = generateChatRoomID(senderID, receiverID);

  //   FirebaseFirestore.instance.collection('chat').add({
  //     'messageID': Uuid().v4(),
  //     'chatRoomID': chatRoomID,
  //     'senderID': senderID,
  //     'receiverID': receiverID,
  //     'text': message,
  //     'createdAt': Timestamp.now(),
  //   });

  //   sendRecentChat(userId: senderID, peerId: receiverID, lastMessage: message);
  //   sendRecentChat(userId: receiverID, peerId: senderID, lastMessage: message);
  //   fetchRecentChats(Get.find<UserProfileController>().idUser);
  // }

  Future<void> sendRecentChat({
    required String userId,
    required String peerId,
    required String lastMessage,
  }) async {
    final url = Uri.parse(
      'https://sibeux.my.id/project/edulink-php-jwt/api/chat',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'peer_id': peerId,
        'last_message': lastMessage,
      }),
    );

    if (response.statusCode == 200) {
      logSuccess('Recent chat sent successfully');
    } else {
      logError('Failed to send recent chat: ${response.body}');
    }
  }

  Future<void> fetchRecentChats(String userId) async {
    isLoadingFetchingRecentChats.value = true;
    final url = Uri.parse(
      'https://sibeux.my.id/project/edulink-php-jwt/api/get_recent_chats.php?user_id=$userId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      recentChats.value = data.map((e) => RecentChat.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recent chats');
    }
    isLoadingFetchingRecentChats.value = false;
    recentChatHasBeenFetched.value != recentChatHasBeenFetched.value;
  }
}
