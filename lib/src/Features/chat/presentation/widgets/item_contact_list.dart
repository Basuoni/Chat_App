import 'package:chat_app/src/Features/chat/presentation/manager/item_contact/item_contact_cubit.dart';
import 'package:chat_app/src/Features/chat/presentation/pages/chatting_screen.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:lottie/lottie.dart';

class ItemContactList extends StatelessWidget {
  final Contact contact;

  const ItemContactList({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemContactCubit(),
      child: BlocConsumer<ItemContactCubit, ItemContactState>(
        listener: (context, state) {
          if (state is ItemContactOpenChatState) {
            Navigator.pushNamed(context, AppRoute.chattingScreen,
                arguments: ChattingScreenArg(
                  chatModel: state.chatModel,
                  anotherUser: state.userModel,
                ));
          }
        },
        builder: (context, state) => buildContainer(context),
        // buildWhen: (previous, current) => false,
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ]),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final itemContactCubit = context.read<ItemContactCubit>();
    itemContactCubit.setContact(contact);
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: 55,
          height: 60,
          child: (contact.photo == null)
              ? const CircleAvatar(child: Icon(Icons.person))
              : CircleAvatar(backgroundImage: MemoryImage(contact.photo!)),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.displayName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              contact.phones.first.number,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            )
          ],
        )),
        Column(
          children: [
            (itemContactCubit.inSearch
                ? Lottie.asset(AppAssets.animSearchContactsItem,
                    width: 40, height: 40, color: AppColors.primary)
                : (itemContactCubit.isFindAccount
                    ? IconButton(
                        onPressed: () {
                          itemContactCubit.openChat();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.primary,
                        ))
                    : IconButton(
                        onPressed: () {
                          itemContactCubit.search();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ))))
          ],
        )
      ],
    );
  }
}
