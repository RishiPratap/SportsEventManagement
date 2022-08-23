import 'dart:convert';
import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:ardent_sports/CreateChallengeTicket.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'WebViewSpots.dart';
import 'package:get/get.dart';

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

  const PoolDetails({
    Key? key,
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
    required this.BreakTime,
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
  List<String> PoolSizes = ['8', '16', '32', '64'];
  String? SelectedPoolSize;

  List<String> PointSystems = ['8', '16', '32', '64', '128'];
  String? SelectedPointSystem;

  List<String> PerMatchEstimatedTime = ['5', '10', '20', '30', '60'];
  String? SelectedPerMatchEstimatedTime;

  final EntryFeeController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  SizedBox(
                    height: deviceWidth * 0.2,
                  ),
                  Card(
                    elevation: 10,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                    ),
                    color: Colors.white.withOpacity(0.1),
                    margin: EdgeInsets.only(
                        left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: deviceWidth * 0.04,
                          ),
                          Container(
                            margin: EdgeInsets.all(deviceWidth * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: DropdownButtonFormField(
                              hint: Text("Pool Size",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontSize: deviceWidth * 0.04,
                                  )),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.06),
                                  )),
                              value: SelectedPoolSize,
                              items: PoolSizes.map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  SelectedPoolSize = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceWidth * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.all(deviceWidth * 0.04),
                            child: TextField(
                              controller: EntryFeeController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.04),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.04),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                  hintText: "Entry Fee",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02),
                                  )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(deviceWidth * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: DropdownButtonFormField(
                              hint: Text("Select Point System",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontSize: deviceWidth * 0.04,
                                  )),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.06),
                                  )),
                              value: SelectedPointSystem,
                              items:
                                  PointSystems.map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  SelectedPointSystem = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceWidth * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.all(deviceWidth * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: DropdownButtonFormField(
                              hint: Text("Per Match Estimated Time",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontSize: deviceWidth * 0.04,
                                  )),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.06),
                                  )),
                              value: SelectedPerMatchEstimatedTime,
                              items: PerMatchEstimatedTime.map(
                                  (value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  SelectedPerMatchEstimatedTime =
                                      value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceWidth * 0.02,
                          ),
                          Container(
                            width: deviceWidth * 0.8,
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                Get.to(WebViewSpots(spots: SelectedPoolSize));
                              },
                              color: Colors.red,
                              child: Text(
                                'Preview Fixture',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.06)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: deviceWidth * 0.8,
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                EasyLoading.show(
                                  status: 'Loading...',
                                  maskType: EasyLoadingMaskType.black,
                                );
                                if (PoolSizes.isNotEmpty &&
                                    EntryFeeController.text.isNotEmpty &&
                                    PointSystems.isNotEmpty &&
                                    PerMatchEstimatedTime.isNotEmpty) {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var obtianedEmail = prefs.getString('email');
                                  print(obtianedEmail);
                                  final ChallengeDetails =
                                      CreateChallengeDetails(
                                          USERID: obtianedEmail!.trim(),
                                          TOURNAMENT_ID: "123456",
                                          CATEGORY: widget.Category,
                                          NO_OF_KNOCKOUT_ROUNDS:
                                              int.parse(SelectedPoolSize!),
                                          ENTRY_FEE: int.parse(
                                              EntryFeeController.text),
                                          PRIZE_POOL: 10000,
                                          TOURNAMENT_NAME: widget.EventName,
                                          CITY: widget.City,
                                          TYPE: widget.EventType,
                                          LOCATION: widget.Address,
                                          START_DATE: widget.StartDate,
                                          END_DATE: widget.EndDate,
                                          START_TIME: widget.StartTime,
                                          END_TIME: widget.EndTime,
                                          REGISTRATION_CLOSES_BEFORE: 6,
                                          AGE_CATEGORY: widget.AgeCategory,
                                          NO_OF_COURTS:
                                              int.parse(widget.NoofCourts),
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
                                  Map<String, dynamic> jsonData =
                                      jsonDecode(response.body);
                                  Get.to(CreateChallengeTicket(
                                    Tournament_ID: jsonData['TOURNAMENT_ID'],
                                  ));
                                  EasyLoading.dismiss();
                                } else {
                                  EasyLoading.showError(
                                      "All fields are required");
                                }
                              },
                              color: Colors.green,
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.06)),
                            ),
                          ),
                          SizedBox(
                            height: deviceWidth * 0.02,
                          ),
                        ],
                      ),
                    ),
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
