import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/chat/presentation/pages/contacts_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final UserModel userData;

  const HomeScreen({Key? key, required this.userData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return   const Scaffold(body: SafeArea(child: ContactsScreen()));
  }
}
