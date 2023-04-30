/*
 * Created by kerolos on 11/14/22, 10:51 PM
 *  Last modified : 11/14/22, 2:24 PM
 */

import 'package:animate_do/animate_do.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:chat_app/src/core/utils/app_assets.dart';
import 'package:chat_app/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    this.color = AppColors.primary,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BuildCondition(
        condition: isLoading,
        builder: (context) => FadeIn(child:  Lottie.asset(AppAssets.animButton)),
        fallback: (context) => FadeIn(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor: MaterialStateProperty.all(color),
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
