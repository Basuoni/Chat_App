
import 'package:chat_app/src/core/utils/constants.dart';

class ChatModel{
  final String id;
  final String first;
  final String second;
  final String lastMessageId;

  const ChatModel({
    required this.id,
    required this.first,
    required this.second,
    required this.lastMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'first' : first,
      'second' : second,
      'lastMessageId' : lastMessageId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      first: map['first'] as String,
      second: map['second'] as String,
      lastMessageId: map['lastMessageId'] as String,
    );
  }
  String getAnotherUser(){
    if(AppConstants.getUser().phoneNumber.compareTo(first)==0) {
      return second;
    } else {
      return first;
    }
  }
}
