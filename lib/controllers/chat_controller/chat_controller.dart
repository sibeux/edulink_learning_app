import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/models/recent_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  var textEditingController = TextEditingController();
  RxString message = ''.obs;

  var isLoadingFetchingRecentChats = false.obs;

  RxList<RecentChat> recentChats = <RecentChat>[].obs;

  String generateChatRoomID(String senderID, String receiverID) {
    if (senderID.compareTo(receiverID) < 0) {
      return '${senderID}_$receiverID';
    } else {
      return '${receiverID}_$senderID';
    }
  }

  Stream<QuerySnapshot> getMessagesFirebase({
    required String senderID,
    required String receiverID,
  }) {
    final chatRoomID = generateChatRoomID(senderID, receiverID);

    return FirebaseFirestore.instance
        .collection('chat')
        .where('chatRoomID', isEqualTo: chatRoomID)
        .orderBy('createdAt')
        .snapshots();
  }

  void sendMessageFirebase({
    required String message,
    required String senderID,
    required String receiverID,
  }) {
    final chatRoomID = generateChatRoomID(senderID, receiverID);

    FirebaseFirestore.instance.collection('chat').add({
      'messageID': Uuid().v4(),
      'chatRoomID': chatRoomID,
      'senderID': senderID,
      'receiverID': receiverID,
      'text': message,
      'createdAt': Timestamp.now(),
    });

    sendRecentChat(userId: senderID, peerId: receiverID, lastMessage: message);
    sendRecentChat(userId: receiverID, peerId: senderID, lastMessage: message);
  }

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
      fetchRecentChats(userId);
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
  }
}
