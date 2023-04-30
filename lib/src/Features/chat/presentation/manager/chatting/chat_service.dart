import 'package:chat_app/src/Features/chat/data/models/message_model.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessageService {
  late Stream<List<MessageModel>> _stream;

  Future<void> _init({required String phoneNumber}) async {

    final Query query = FirebaseFirestore.instance.collection(AppConstants.fKMessages)
        .where('chatId', isEqualTo: AppConstants.createIdByNumbers(phoneNumber));
    final Stream<QuerySnapshot> snapshots = query.snapshots();

    _stream = snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((element) =>
              MessageModel.fromMap(element.data() as Map<String, dynamic>))
          .toList();
      return result;
    });

  }

  Stream<List<MessageModel>> stream() { return _stream; }

  getChatMessageStreamProvider({required String phoneNumber}) {
    return StreamProvider<List<MessageModel>>((ref) {
      final service = ChatMessageService();
      service._init(phoneNumber: phoneNumber);
      return service._stream;
    });
  }
}

