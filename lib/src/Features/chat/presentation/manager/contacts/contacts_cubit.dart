import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial()) {
    _init();
    searchController.addListener(() {
      _search(searchController.text.trim());
    });
  }

  TextEditingController searchController = TextEditingController();
  List<Contact> contacts = [];
  final List<Contact> _allContacts = [];
  bool isLoadingContacts = true;

  void _init() async {
    if (await FlutterContacts.requestPermission()) {
      final List<Contact> contactFilter = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      contacts =
          contactFilter.where((value) => value.phones.isNotEmpty).toList();
      _allContacts.addAll(contacts);
      log("contact : ${contacts.length}");
      Future.delayed(const Duration(seconds: 5), () {
        isLoadingContacts = false;
        log("get All");
        emit(DoneContactsState());
      });
    }
  }

  void _search(String name) {
    if (name.isEmpty) {
      contacts = _allContacts;
    } else {
      final List<Contact> contact = [];
      contact.addAll(_allContacts);
      contact.retainWhere((element) {
        return element.displayName.toLowerCase().contains(name.toLowerCase());
      });
      contacts = contact;
    }
    emit(RefreshContactsState());
  }
}
