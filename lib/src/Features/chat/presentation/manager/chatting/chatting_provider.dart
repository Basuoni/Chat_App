import 'dart:developer';

import 'package:chat_app/src/Features/chat/data/repositories/chatting_repository.dart';
import 'package:chat_app/src/core/firebase/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chattingNotifier =
    ChangeNotifierProvider<ChattingNotifier>((ref) => ChattingNotifier());

class ChattingNotifier extends ChangeNotifier {
  void sendMessage({required String message, required String senderPhone}) async {
    final res = await ChattingRepository.sendMessage(
        message: message, senderPhone: senderPhone);
    if (res is SuccessfulResponse) {
      log("SuccessfulResponse");
    } else {
      log("ErrorResponse: ${res.message}");
    }
    notifyListeners();
  }
}
