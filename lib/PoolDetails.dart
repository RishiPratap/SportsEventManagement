import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoolDetails extends StatefulWidget {
  final String? SportName;
  final String EventManagerName;
  final String EventManagerMobileNo;
  final String? EventType;
  final String EventName;
  final String StartDate;
  final String EndDate;
  final String StartTime;
  final String EndTime;
  final String City;
  final String Address;
  final String? Category;
  final String? AgeCategory;
  final String RegistrationCloses;
  final String NoofCourts;
  final String BreakTime;

  const PoolDetails(
      {Key? key,
      required this.SportName,
      required this.EventManagerName,
      required this.EventManagerMobileNo,
      required this.EventType,
      required this.EventName,
      required this.StartDate,
      required this.EndDate,
      required this.StartTime,
      required this.EndTime,
      required this.City,
      required this.Address,
      required this.Category,
      required this.AgeCategory,
      required this.RegistrationCloses,
      required this.NoofCourts,
      required this.BreakTime})
      : super(key: key);
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        print(widget.AgeCategory);
                        print(widget.Category);
                        print(widget.RegistrationCloses);
                        print(widget.NoofCourts);
                        print(widget.BreakTime);
                        print(widget.SportName);
                        print(widget.EventManagerName);
                        print(widget.EventManagerMobileNo);
                        print(widget.EventType);
                        print(widget.EventName);
                        print(widget.StartDate);
                        print(widget.EndDate);
                        print(widget.StartTime);
                        print(widget.EndTime);
                        print(widget.City);
                        print(widget.Address);

                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var obtianedEmail = prefs.getString('email');
                        print(obtianedEmail);
                        final ChallengeDetails = CreateChallengeDetails(
                            USERID: obtianedEmail!.trim(),
                            TOURNAMENT_ID: "123456",
                            CATEGORY: widget.Category,
                            NO_OF_KNOCKOUT_ROUNDS: 32,
                            ENTRY_FEE: 500,
                            PRIZE_POOL: 10000,
                            TOURNAMENT_NAME: widget.EventName,
                            CITY: widget.City,
                            TYPE: widget.EventType,
                            LOCATION: widget.Address,
                            START_DATE: widget.StartDate,
                            END_DATE: widget.EndDate,
                            START_TIME: "14:25",
                            END_TIME: "16:15",
                            REGISTRATION_CLOSES_BEFORE: 6,
                            AGE_CATEGORY: widget.AgeCategory,
                            NO_OF_COURTS: 5, // int.parse(widget.NoofCourts)
                            BREAK_TIME: widget.BreakTime,
                            SPORT: widget.SportName);
                        final DetailMap = ChallengeDetails.toMap();
                        final json = jsonEncode(DetailMap);
                        var url =
                            "https://ardentsportsapis.herokuapp.com/createTournament";
                        var response = await post(Uri.parse(url),
                            headers: {
                              "Accept": "application/json",
                              "Content-Type": "application/json"
                            },
                            body: json,
                            encoding: Encoding.getByName("utf-8"));
                        print(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(response.body),
                        ));
                      },
                      child: Text("Submit"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardPoolDetails() => Card(
        elevation: 10,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.white.withOpacity(0.1),
        margin: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (MS,WS,etc..)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (MS,WS,etc..)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (MS,WS,etc..)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (MS,WS,etc..)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (MS,WS,etc..)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ],
        ),
      );
}
