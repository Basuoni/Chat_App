import 'package:bloc/bloc.dart';
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:chat_app/src/Features/auth/data/repositories/auth_repostory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  Future<void> sendCode() async {
    isLoading = true;
    emit(RefreshAuthState());
    String phone = phoneController.text;
    final res = await AuthRepository.sendCode(
      phone: phone,
      callSend: (String verificationId) {
        isLoading = false;
        emit(DoneSendState(verificationId: verificationId, phoneNumber: phone));
      },
      callError: (String e) {
        isLoading = false;
        emit(ErrorAuthState(e));
      },
    );
    if (!res.isSuccessful) {
      isLoading = false;
      emit(ErrorAuthState(res.message));
    }
  }

  void verificationCode({
    required String code,
    required String verificationId,
    required String phoneNumber,
  }) async {
    isLoading = true;
    emit(RefreshAuthState());

    final res = await AuthRepository.verificationCode(
        code: code,
        verificationId: verificationId,
        phoneNumber: phoneNumber,
        account: (UserModel ? userModel) {
          isLoading = false;
          emit(DoneAuthState(userModel: userModel));
        }
    );

    isLoading = false;
    if (!res.isSuccessful) {
      emit(ErrorAuthState(res.message));
    }
  }

  void addUser({required String phone, XFile? image}) async {
    isLoading = true;
    emit(RefreshAuthState());
    final res = await AuthRepository.addUser(
        name: nameController.text, phoneNumber: phone, image: image,
        account: (UserModel userModel) {
          isLoading = false;
          emit(DoneAuthState(userModel: userModel));
        }
    );

    isLoading = false;
    if (!res.isSuccessful) {
      emit(ErrorAuthState(res.message));
    }
  }

  void onPinChanged() {
    emit(PinChangedAuthState());
  }

  void screenChanged() {
    emit(ScreenChangedAuthState());
  }

  void refreshImage() {
    emit(RefreshAuthState());
  }

}
