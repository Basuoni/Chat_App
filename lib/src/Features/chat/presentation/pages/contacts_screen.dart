
import 'package:animate_do/animate_do.dart';
import 'package:chat_app/src/Features/chat/presentation/manager/contacts/contacts_cubit.dart';
import 'package:chat_app/src/Features/chat/presentation/widgets/item_contact_list.dart';
import 'package:chat_app/src/core/components/app_textfield.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:lottie/lottie.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsCubit(),
      child: BlocConsumer<ContactsCubit, ContactsState>(
        listener: (context, state) {},
        builder: (context, state) => buildBody(context),
        // buildWhen: (previous, current) => false,
      ),
    );
  }

  Scaffold buildBody(BuildContext context) {
    final contactsCubit = context.read<ContactsCubit>();
    return Scaffold(
      body: Column(
        children: [
          AppTextField(
            hint: "Search by name",
            prefixIcon: Icons.search,
            txtController: contactsCubit.searchController,
            suffixIcon: Icons.cancel_outlined,
            onPressedIcon: () {
             contactsCubit.searchController.text = "";
            },
            onChanged: (value) {

            },
          ),
          Expanded(
            child: (contactsCubit.isLoadingContacts
                ? FadeInDown(
                    duration: const Duration(milliseconds: 900),
                    child: Lottie.asset(AppAssets.animContactsScreen,
                        width: 300, height: 300,))
                : customListView(contactsCubit.contacts)),
          ),
        ],
      ),
    );
  }

  customListView(List<Contact> contacts){
    return ListView.builder(
      itemBuilder: (context, index) =>
          ItemContactList(contact: contacts[index]),
      itemCount: contacts.length,
    );
  }
}
