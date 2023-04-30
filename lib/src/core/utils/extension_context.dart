import 'package:another_flushbar/flushbar.dart';
import 'package:chat_app/src/core/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension MediaQueryValue on BuildContext{
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension TopSnackBar on BuildContext{
  void showTopSnackBar({required bool isError, required String title, required String mess}) =>
      Flushbar(
        icon: ( isError ? const Icon(Icons.report_gmailerrorred_outlined, size: 35, color: Colors.red):
        const Icon(Icons.done_all, size: 35, color: AppColors.primary)
        ),
        shouldIconPulse: false,
        backgroundGradient: const LinearGradient(
          colors: [Colors.white, Colors.white70],
        ),
        boxShadows: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 8,
          )
        ],
        title: title,
        //' Error Authentication !',
        message: mess,
        titleColor: isError ? Colors.red : AppColors.primary,
        messageColor: Colors.black,
        //'Check your email',
        duration: const Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
        borderRadius: BorderRadius.circular(16.0),
      )
        ..show(this);
}