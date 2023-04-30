import 'package:chat_app/src/core/utils/constants.dart';

class UserModel{
 final String name;
 final String phoneNumber;
 final String image;

 UserModel({required this.name, required this.phoneNumber, required this.image});

  Map<String, dynamic> toMap() {
    return {
      AppConstants.fKUserName: name,
      AppConstants.fKUserPhone: phoneNumber,
      AppConstants.fKUserImage: image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map[AppConstants.fKUserName] as String,
      phoneNumber: map[AppConstants.fKUserPhone] as String,
      image: map[AppConstants.fKUserImage] as String,
    );
  }
}