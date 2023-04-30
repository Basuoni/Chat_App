import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/config/app_theme.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppConstants.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: AppTheme.mainTheme(),
      onGenerateRoute: AppGenerateRoute.onGenerateRoute,
    );
  }
}
