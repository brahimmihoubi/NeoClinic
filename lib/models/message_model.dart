class MessageModel {
  final String content;
  final DateTime timestamp;
  final bool isSentByUser;

  MessageModel({
    required this.content,
    required this.timestamp,
    required this.isSentByUser,
  });
}