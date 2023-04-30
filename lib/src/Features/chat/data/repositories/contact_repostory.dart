import 'dart:developer';

import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/chat/data/models/chat_model.dart';
import 'package:chat_app/src/core/firebase/response.dart';
import 'package:chat_app/src/core/utils/app_strings.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {

  static Future<ResponseFire> searchAboutContact({
    required String phone,
    required Function(UserModel? userModel) account,
  }) async {
    try {
      final userDocumentSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.fKUsers)
          .doc(AppConstants.localNumber(phone))
          .get();
      if (userDocumentSnapshot.exists) {
        account(UserModel.fromMap(userDocumentSnapshot.data()!));
      } else {
        account(null);
      }
      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      return ErrorResponse(e.message!);
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }

  static Future<ResponseFire> openChat({
    required String number,
    required Function(ChatModel chatModel) getChatModel,
  }) async {
    try {
      final chatId = AppConstants.createIdByNumbers(number);
      final chatDocumentSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.fKChats)
          .doc(chatId)
          .get();
      if (!chatDocumentSnapshot.exists) {
        ChatModel chatModel = ChatModel(id: chatId,
            first: AppConstants.getFirstNumber(number),
            second: AppConstants.getSecondNumber(number),
            lastMessageId: "");
        await FirebaseFirestore.instance
            .collection(AppConstants.fKChats).doc(chatId).set(chatModel.toMap());
        getChatModel(chatModel);
      }else {
        getChatModel(ChatModel.fromMap(chatDocumentSnapshot.data()!));
      }
      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      return ErrorResponse(e.message!);
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }
}
