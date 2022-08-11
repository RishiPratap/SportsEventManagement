import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoolDetails extends StatefulWidget {
  // final String? SportName;
  // final String EventManagerName;
  // final String EventManagerMobileNo;
  // final String? EventType;
  // final String EventName;
  // final String StartDate;
  // final String EndDate;
  // final String StartTime;
  // final String EndTime;
  // final String City;
  // final String Address;
  // final String? Category;
  // final String? AgeCategory;
  // final String RegistrationCloses;
  // final String NoofCourts;
  // final String BreakTime;

  const PoolDetails({
    Key? key,
    // required this.SportName,
    // required this.EventManagerName,
    // required this.EventManagerMobileNo,
    // required this.EventType,
    // required this.EventName,
    // required this.StartDate,
    // required this.EndDate,
    // required this.StartTime,
    // required this.EndTime,
    // required this.City,
    // required this.Address,
    // required this.Category,
    // required this.AgeCategory,
    // required this.RegistrationCloses,
    // required this.NoofCourts,
    // required this.BreakTime
  }) : super(key: key);
  @override
  State<PoolDetails> createState() => _PoolDetailsState();
}

class CreateChallengeDetails {
  late String USERID;
  late String TOURNAMENT_ID;
  late String? CATEGORY;
  late int NO_OF_KNOCKOUT_ROUNDS;
  late int ENTRY_FEE;
  late int PRIZE_POOL;
  late String TOURNAMENT_NAME;
  late String CITY;
  late String? TYPE;
  late String LOCATION;
  late String START_DATE;
  late String END_DATE;
  late String START_TIME;
  late String END_TIME;
  late int REGISTRATION_CLOSES_BEFORE;
  late String? AGE_CATEGORY;
  late int NO_OF_COURTS;
  late String BREAK_TIME;
  late String? SPORT;

  CreateChallengeDetails(
      {required this.USERID,
      required this.TOURNAMENT_ID,
      required this.CATEGORY,
      required this.NO_OF_KNOCKOUT_ROUNDS,
      required this.ENTRY_FEE,
      required this.PRIZE_POOL,
      required this.TOURNAMENT_NAME,
      required this.CITY,
      required this.TYPE,
      required this.LOCATION,
      required this.START_DATE,
      required this.END_DATE,
      required this.START_TIME,
      required this.END_TIME,
      required this.REGISTRATION_CLOSES_BEFORE,
      required this.AGE_CATEGORY,
      required this.NO_OF_COURTS,
      required this.BREAK_TIME,
      required this.SPORT});
  Map<String, dynamic> toMap() {
    return {
      "USERID": this.USERID,
      "TOURNAMENT_ID": this.TOURNAMENT_ID,
      "CATEGORY": this.CATEGORY,
      "NO_OF_KNOCKOUT_ROUNDS": this.NO_OF_KNOCKOUT_ROUNDS,
      "ENTRY_FEE": this.ENTRY_FEE,
      "PRIZE_POOL": this.PRIZE_POOL,
      "TOURNAMENT_NAME": this.TOURNAMENT_NAME,
      "CITY": this.CITY,
      "TYPE": this.TYPE,
      "LOCATION": this.LOCATION,
      "START_DATE": this.START_DATE,
      "END_DATE": this.END_DATE,
      "START_TIME": this.START_TIME,
      "END_TIME": this.END_TIME,
      "REGISTRATION_CLOSES_BEFORE": this.REGISTRATION_CLOSES_BEFORE,
      "AGE_CATEGORY": this.AGE_CATEGORY,
      "NO_OF_COURTS": this.NO_OF_COURTS,
      "BREAK_TIME": this.BREAK_TIME,
      "SPORT": this.SPORT
    };
  }
}

class _PoolDetailsState extends State<PoolDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 90,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/AARDENT_LOGO.png"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/Ardent_Sport_Text.png"),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
