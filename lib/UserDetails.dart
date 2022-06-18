import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class UserDetails {
  late String USERID;
  late String PHONE;
  late String NAME;
  late String EMAIL;
  late String PWD;
  late String GENDER;
  late String DOB;
  late String CITY;
  late String STATE;
  late String SPORTS_ACADEMY;
  late String PROFILE_ID;
  late String INTERESTED_SPORTS;
  List FRIENDS_LIST = [];
  UserDetails(
      {required this.USERID,
      required this.PHONE,
      required this.NAME,
      required this.EMAIL,
      required this.PWD,
      required this.GENDER,
      required this.DOB,
      required this.CITY,
      required this.STATE,
      required this.SPORTS_ACADEMY,
      required this.PROFILE_ID,
      required this.INTERESTED_SPORTS});
  Map<String, dynamic> toMap() {
    return {
      "USERID": this.USERID,
      "PHONE": this.PHONE,
      "NAME": this.NAME,
      "EMAIL": this.EMAIL,
      "PWD": this.PWD,
      "GENDER": this.GENDER,
      "DOB": this.DOB,
      "CITY": this.CITY,
      "STATE": this.STATE,
      "SPORTS_ACADEMY": this.SPORTS_ACADEMY,
      "PROFILE_ID": this.PROFILE_ID,
      "INTERESTED_SPORTS": this.INTERESTED_SPORTS,
      "FRIENDS_LIST": this.FRIENDS_LIST,
    };
  }
}

class LoginDetails {
  late String EmailId;
  late String Password;
  LoginDetails({required this.EmailId, required this.Password});
  Map<String, dynamic> toMap() {
    return {
      "loginid": this.EmailId,
      "pwd": this.Password,
    };
  }
}
