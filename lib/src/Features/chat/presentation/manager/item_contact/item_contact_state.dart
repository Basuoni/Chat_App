part of 'item_contact_cubit.dart';

@immutable
abstract class ItemContactState {}

class ItemContactInitial extends ItemContactState {}

class ItemContactRefreshState extends ItemContactState {}

class ItemContactOpenChatState extends ItemContactState {
  final ChatModel chatModel;
  final UserModel userModel;

  ItemContactOpenChatState({
    required this.chatModel,
    required this.userModel,
  });
}
