import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoolDetails extends StatefulWidget {
  final String SportName;
  final String EventManagerName;
  final String EventManagerMobileNo;
  final String EventType;
  final String EventName;
  final String StartDate;
  final String EndDate;
  final String StartTime;
  final String EndTime;
  final String City;
  final String Address;
  final String Category;
  final String AgeCategory;
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
  late String CATEGORY;
  late String NO_OF_KNOCKOUT_ROUNDS;
  late String ENTRY_FEE;
  late String PRIZE_POOL;
  late String TOURNAMENT_NAME;
  late String CITY;
  late String LOCATION;
  late String START_DATE;
  late String END_DATE;
  late String SPORT;

  CreateChallengeDetails(
      {required this.USERID,
      required this.TOURNAMENT_ID,
      required this.CATEGORY,
      required this.NO_OF_KNOCKOUT_ROUNDS,
      required this.ENTRY_FEE,
      required this.PRIZE_POOL,
      required this.TOURNAMENT_NAME,
      required this.CITY,
      required this.LOCATION,
      required this.START_DATE,
      required this.END_DATE,
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
      "LOCATION": this.LOCATION,
      "START_DATE": this.START_DATE,
      "END_DATE": this.END_DATE,
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
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var obtianedEmail = prefs.getString('email');
                        final ChallengeDetails = CreateChallengeDetails(
                            USERID: obtianedEmail!,
                            TOURNAMENT_ID:
                                "${obtianedEmail}${widget.SportName}",
                            CATEGORY: widget.Category,
                            NO_OF_KNOCKOUT_ROUNDS: "32",
                            ENTRY_FEE: "500",
                            PRIZE_POOL: "10000",
                            TOURNAMENT_NAME: widget.EventName,
                            CITY: widget.City,
                            LOCATION: widget.Address,
                            START_DATE: widget.StartDate,
                            END_DATE: widget.EndDate,
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(response.body),
                        ));
                      },
                      child: Text("Send Data to Doraemons BackEnd"),
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
