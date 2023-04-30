part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RefreshAuthState extends AuthState {}

class DoneAuthState extends AuthState {
  final UserModel ? userModel;
  DoneAuthState({this.userModel});
}

class PinChangedAuthState extends AuthState {}
class ScreenChangedAuthState extends AuthState {}

class DoneSendState extends AuthState {
  final String verificationId;
  final String phoneNumber;
  DoneSendState({required this.verificationId,required this.phoneNumber});
}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState(this.message);
}
