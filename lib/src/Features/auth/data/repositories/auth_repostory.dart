import 'dart:developer';
import 'dart:io';

import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/core/firebase/response.dart';
import 'package:chat_app/src/core/utils/app_strings.dart';
import 'package:chat_app/src/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static Future<ResponseFire> sendCode({
    required String phone,
    required Function(String verificationId) callSend,
    required Function(String e) callError,
  }) async {
    try {
      // log(phone);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) {
          // log("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            callError('The provided phone number is not valid.');
          } else {
            callError(AppStrings.unexpectedError);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          callSend(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      return ErrorResponse(e.message!);
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }

  static Future<ResponseFire> verificationCode({
    required String code,
    required String verificationId,
    required String phoneNumber,
    required Function(UserModel? userModel) account,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      final userAuth = await FirebaseAuth.instance.signInWithCredential(
          credential);
      log(userAuth.user!.uid);
      final userDocumentSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.fKUsers)
          .doc(phoneNumber)
          .get();
      if (userDocumentSnapshot.exists) {
        account(UserModel.fromMap(userDocumentSnapshot.data()!));
      } else {
        account(null);
      }

      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      log(e.code);
      if (e.code == 'invalid-verification-code') {
        return ErrorResponse('The provided verification code is not valid.');
      }
      if (e.code == 'invalid-verification-id') {
        return ErrorResponse('The provided code has expired.');
      } else {
        return ErrorResponse(AppStrings.unexpectedError);
      }
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }

  static Future<ResponseFire> addUser({
    required String name,
    required String phoneNumber,
    XFile? image,
    required Function(UserModel userModel) account,
  }) async {
    try {
      String pathImage = '';
      if (image != null) {
        final ref =
        FirebaseStorage.instance.ref().child(AppConstants.fKImages).child(phoneNumber);
        await ref.putFile(File(image.path));
        pathImage = await ref.getDownloadURL();
      }
      final user =
      UserModel(name: name, phoneNumber: phoneNumber, image: pathImage);
      CollectionReference users =
      FirebaseFirestore.instance.collection(AppConstants.fKUsers);
      await users.doc(phoneNumber).set(user.toMap());
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.sKUser, user.toMap().toString());
      account(user);
      return SuccessfulResponse();
    } on FirebaseException catch (e) {
      log(e.code);
      return ErrorResponse(AppStrings.unexpectedError);
    } catch (e) {
      log(e.toString());
      return ErrorResponse(AppStrings.unexpectedError);
    }
  }
}
