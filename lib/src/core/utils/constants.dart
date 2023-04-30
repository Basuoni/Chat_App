
import 'package:chat_app/src/Features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  // SharedPreferences Key
  static const String sKUser = "User";

  // firebase collections Key
  static const String fKUsers = "Users";
  static const String fKChats = "Chats";
  static const String fKMessages = "Messages";


  // firebase fields Key
  static const String fKImages = "Images";
  static const String fKUserName = "UserName";
  static const String fKUserPhone = "UserPhone";
  static const String fKUserImage = "UserImage";



  // init Class from main
  static SharedPreferences? _preferences;
  static Future<void> init()async{
    _preferences = await SharedPreferences.getInstance();
  }


  // get User Data
  static UserModel getUser(){
    final user = _preferences!.getString(AppConstants.sKUser);
    return UserModel.fromMap(jsonStringToMap(user!));
  }


  // create one template
  static String localNumber(String phone) {
    String phoneNumber = '';

    for (int i = 0; i < phone.length; i++) {
      if (phone[i] != ' ') {
        phoneNumber += phone[i];
      }
    }
    if (phone[0] != '+') phoneNumber = '+2$phoneNumber';
    return phoneNumber;
  }

  static String createIdByNumbers(String phone2) {
    String phoneNumber1 = localNumber(getUser().phoneNumber);
    String phoneNumber2 = localNumber(phone2);
    var result = phoneNumber1.compareTo(phoneNumber2);
    if (result < 0) {
      return phoneNumber1 + phoneNumber2;
    } else {
      return phoneNumber2 + phoneNumber1;
    }
  }

  static String getFirstNumber(String phone2) {
    String phoneNumber1 = localNumber(getUser().phoneNumber);
    String phoneNumber2 = localNumber(phone2);
    var result = phoneNumber1.compareTo(phoneNumber2);
    if (result < 0) {
      return phoneNumber1;
    } else {
      return phoneNumber2;
    }
  }

  static String getSecondNumber(String phone2) {
    String phoneNumber1 = localNumber(getUser().phoneNumber);
    String phoneNumber2 = localNumber(phone2);
    var result = phoneNumber1.compareTo(phoneNumber2);
    if (result < 0) {
      return phoneNumber2;
    } else {
      return phoneNumber1;
    }
  }

  static bool isFirstNumber(String phone2) {
    String phoneNumber1 = localNumber(getUser().phoneNumber);
    String phoneNumber2 = localNumber(phone2);
    var result = phoneNumber1.compareTo(phoneNumber2);
    return result < 0;
  }

  static Map<String,dynamic> jsonStringToMap(String data){
    List<String> str = data.replaceAll("{","").replaceAll("}","").replaceAll("\"","").replaceAll("'","").split(",");
    Map<String,dynamic> result = {};
    for(int i=0;i<str.length;i++){
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }
}
