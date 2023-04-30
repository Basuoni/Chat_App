import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/auth/presentation/pages/phone_screen.dart';
import 'package:chat_app/src/Features/auth/presentation/pages/information_scren.dart';
import 'package:chat_app/src/Features/auth/presentation/pages/splash_screen.dart';
import 'package:chat_app/src/Features/auth/presentation/pages/verification_screen.dart';
import 'package:chat_app/src/Features/chat/presentation/pages/chatting_screen.dart';
import 'package:chat_app/src/Features/chat/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String main = '/main';
  static const String splashScreen = '/';
  static const String phoneScreen = '/phoneScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String informationScreen = '/informationScreen';
  static const String homeScreen = '/homeScreen';
  static const String chattingScreen = '/chattingScreen';

}

class AppGenerateRoute {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case AppRoute.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

        case AppRoute.phoneScreen:
        return MaterialPageRoute(builder: (context) => const PhoneScreen());

      case AppRoute.verificationScreen:
        final arguments = settings.arguments as VerificationScreenArg;
        return MaterialPageRoute(
            builder: (context) => VerificationScreen(
                  arguments: arguments,
                ));

      case AppRoute.informationScreen:
        final arguments = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => InformationScreen(userModel: arguments));

        case AppRoute.homeScreen:
        final arguments = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => HomeScreen(userData: arguments));

      case AppRoute.chattingScreen:
        final arguments = settings.arguments as ChattingScreenArg;
        return MaterialPageRoute(
            builder: (context) => ChattingScreen(arguments: arguments));
    }

    return null;
  }
}
