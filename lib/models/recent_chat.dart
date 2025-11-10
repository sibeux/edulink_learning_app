class RecentChat {
  final String peerId;
  final String lastMessage;
  final DateTime updatedAt;
  final String fullname;
  final String uriPhoto;

  RecentChat({
    required this.peerId,
    required this.lastMessage,
    required this.updatedAt,
    required this.fullname,
    required this.uriPhoto,
  });

  factory RecentChat.fromJson(Map<String, dynamic> json) {
    return RecentChat(
      peerId: json['peer_id'],
      lastMessage: json['last_message'],
      updatedAt: DateTime.parse(json['updated_at']),
      fullname: json['full_name'],
      uriPhoto: json['user_photo'],
    );
  }
}
