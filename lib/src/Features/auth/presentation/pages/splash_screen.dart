import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/config/app_route.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/app_colors.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    checkData(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            FadeInDown(
                duration: const Duration(milliseconds: 1100),
                child: Lottie.asset(AppAssets.animSplash)),
            Expanded(child: Container()),
            FadeInUp(
                duration: const Duration(milliseconds: 1100),
                child: SvgPicture.asset(AppAssets.iconApp,height: 100,color: AppColors.primary,)
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkData(BuildContext context) async {
     final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(AppConstants.sKUser);
    log("message: $user");
    await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context,
            (user != null ? AppRoute.homeScreen : AppRoute.phoneScreen),
            arguments:(user != null ? UserModel.fromMap(AppConstants.jsonStringToMap(user)) :null) );
    });
  }

}
