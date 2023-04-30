class MessageModel {
  final String message;
  final String sender;
  final String chatId;
  final List<String> readers;

  const MessageModel({
    required this.message,
    required this.sender,
    required this.chatId,
    required this.readers,
  });

  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'sender' : sender,
      'chatId' : chatId,
      'readers' : readers,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      sender: map['sender'] as String,
      chatId: map['chatId'] as String,
      readers: map['readers'] as List<String>,
    );
  }
}