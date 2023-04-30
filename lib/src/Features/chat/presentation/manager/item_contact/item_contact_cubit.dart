import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/chat/data/models/chat_model.dart';
import 'package:chat_app/src/Features/chat/data/repositories/contact_repostory.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:meta/meta.dart';

part 'item_contact_state.dart';

class ItemContactCubit extends Cubit<ItemContactState> {
  ItemContactCubit() : super(ItemContactInitial());
  Contact _contact = Contact();
  bool inSearch = false;
  bool isFindAccount = false;
  UserModel? _userModel;
  void setContact(Contact contact) {
    _contact = contact;
  }

  void search() async {
    inSearch = true;
    emit(ItemContactRefreshState());
    await ContactRepository.searchAboutContact(
        phone: _contact.phones.first.number,
        account: (UserModel? user) {
          inSearch = false;
          if (user != null) {
            isFindAccount = true;
            _userModel = user;
          }
          log(user.toString());
          emit(ItemContactRefreshState());
        });
    inSearch = false;
    emit(ItemContactRefreshState());
  }

  void openChat() async {
    inSearch = true;
    emit(ItemContactRefreshState());
    await ContactRepository.openChat(
      number: _contact.phones.first.number,
      getChatModel: (chatModel) {
        inSearch = true;
        emit(ItemContactOpenChatState(chatModel: chatModel,userModel: _userModel!));
      },
    );
    inSearch = false;
    emit(ItemContactRefreshState());
  }
}
