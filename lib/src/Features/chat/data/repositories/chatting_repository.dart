import 'dart:developer';

import 'package:chat_app/src/Features/chat/data/models/message_model.dart';
import 'package:chat_app/src/core/firebase/response.dart';
import 'package:chat_app/src/core/utils/app_strings.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingRepository {
  ChattingRepository._();
  static final instance = ChattingRepository._();

  static Future<ResponseFire> sendMessage({
    required String message,
    required String senderPhone,
  }) async {
    try {

      final messageDocumentSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.fKMessages)
          .add(MessageModel(
              message: message,
              sender: senderPhone,
              chatId: AppConstants.createIdByNumbers(senderPhone),
              readers: []).toMap());

      log(messageDocumentSnapshot.id);
      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      return ErrorResponse(e.message!);
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }
}
