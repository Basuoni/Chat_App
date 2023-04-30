import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/chat/data/models/chat_model.dart';
import 'package:chat_app/src/Features/chat/presentation/manager/chatting/chat_service.dart';
import 'package:chat_app/src/Features/chat/presentation/manager/chatting/chatting_provider.dart';
import 'package:chat_app/src/core/components/app_textfield.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChattingScreenArg {
  final ChatModel chatModel;
  final UserModel anotherUser;

  const ChattingScreenArg({
    required this.chatModel,
    required this.anotherUser,
  });
}

class ChattingScreen extends ConsumerWidget {
  ChattingScreen({Key? key, required this.arguments}) : super(key: key);
  final ChattingScreenArg arguments;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lis = ref.watch(chattingNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 55,
              height: 50,
              child: (arguments.anotherUser.image.isEmpty)
                  ? const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(arguments.anotherUser.image)),
            ),
            const SizedBox(width: 5),
            Text(arguments.anotherUser.name)
          ],
        ),
      ),
      body: Column(
        children: [
          const _ListMessage(),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                      child: AppTextField(
                          hint: "Message",
                          prefixIcon: null,
                          txtController: messageController))),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(12),
                width: 50,
                height: 55,
                margin: const EdgeInsets.only(right: 10),
                child: InkWell(
                  child: SvgPicture.asset(AppAssets.iconSend),
                  onTap: () {
                    lis.sendMessage(message:  messageController.text,
                       senderPhone:  arguments.anotherUser.phoneNumber);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ListMessage extends ConsumerWidget {
  const _ListMessage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,ref) {
    final chatMessageService = ChatMessageService();

    final lis = ref.watch(chatMessageService.getChatMessageStreamProvider(phoneNumber: "phoneNumber"));
    return Expanded(child: Text(''));
  }
}
