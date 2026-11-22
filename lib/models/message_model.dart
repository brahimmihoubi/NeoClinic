class MessageModel {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isSentByUser;
  final int? senderId;
  final int? receiverId;

  MessageModel({
    this.id = '',
    required this.content,
    required this.timestamp,
    required this.isSentByUser,
    this.senderId,
    this.receiverId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, int currentUserId) {
    final senderId = json['sender_id'] != null ? int.tryParse(json['sender_id'].toString()) : null;
    final parsedDate = DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now();
    return MessageModel(
      id: json['id']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      timestamp: parsedDate,
      isSentByUser: senderId == currentUserId,
      senderId: senderId,
      receiverId: json['receiver_id'] != null ? int.tryParse(json['receiver_id'].toString()) : null,
    );
  }
}
