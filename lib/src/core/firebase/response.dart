
import 'package:chat_app/src/core/utils/app_strings.dart';

class ResponseFire<tt>{
  tt ?data;
  String message = AppStrings.successProcess;
  bool isSuccessful = true;
}
class SuccessfulResponse extends ResponseFire{}

class ErrorResponse extends ResponseFire{
  ErrorResponse(String massage){
    super.message = massage;
    super.isSuccessful = false;
  }
}

