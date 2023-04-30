import 'package:chat_app/src/Features/chat/data/models/message_model.dart';

class ChatUserModel{
  final String phone;
  final bool writing;
  final List<MessageModel> messages;

  const ChatUserModel({
    required this.phone,
    required this.writing,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'writing': writing,
      'messages': messages,
    };
  }

  factory ChatUserModel.fromMap(Map<String, dynamic> map) {
    return ChatUserModel(
      phone: map['phone'] as String,
      writing: map['writing'] as bool,
      messages: map['messages'] as List<MessageModel>,
    );
  }
}