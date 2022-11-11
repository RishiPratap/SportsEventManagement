// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:ardent_sports/CreateChallengeTicket.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CategoryDetails.dart';
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
  final List<CategorieDetails> AllCategoryDetails;

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
      required this.BreakTime,
      required this.AllCategoryDetails})
      : super(key: key);
  @override
  State<PoolDetails> createState() => _PoolDetailsState();
}

class CreateChallengeDetails {
  late String USERID;
  late String TOURNAMENT_ID;
  late String? CATEGORY;
  late String NO_OF_KNOCKOUT_ROUNDS;
  late String ENTRY_FEE;
  late String? GOLD;
  late String? SILVER;
  late String? BRONZE;
  late String? OTHER;
  late String? PRIZE_POOL;
  late String TOURNAMENT_NAME;
  late String CITY;
  late String? TYPE;
  late String LOCATION;
  late String START_DATE;
  late String END_DATE;
  late String START_TIME;
  late String END_TIME;
  late int REGISTRATION_CLOSES_BEFORE;
  late String AGE_CATEGORY;
  late String NO_OF_COURTS;
  late String BREAK_TIME;
  late String? SPORT;

  CreateChallengeDetails(
      {required this.USERID,
      required this.TOURNAMENT_ID,
      required this.CATEGORY,
      required this.NO_OF_KNOCKOUT_ROUNDS,
      required this.ENTRY_FEE,
      required this.GOLD,
      required this.SILVER,
      required this.BRONZE,
      required this.OTHER,
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
      "GOLD": this.GOLD,
      "SILVER": this.SILVER,
      "BRONZE": this.BRONZE,
      "OTHER": this.OTHER,
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

class details {
  late String PoolSize;
  late String gold;
  late String silver;
  late String bronze;
  late String others;
  late String entryfee;
  late String pointsystem;
  late String PerMatchEstimatedTime;

  details(
      {required this.PoolSize,
      required this.gold,
      required this.silver,
      required this.bronze,
      required this.others,
      required this.entryfee,
      required this.pointsystem,
      required this.PerMatchEstimatedTime});
}

class _PoolDetailsState extends State<PoolDetails> {
  PageController pageController = PageController(viewportFraction: 0.9);
  double _currPageValue = 0.0;
  List<String> PoolSizes = ['8', '16', '32', '64'];
  String? SelectedPoolSize;

  List<String> PointSystems = ['8', '16', '32', '64', '128'];
  String? SelectedPointSystem;

  List<String> PerMatchEstimatedTime = ['5', '10', '20', '30', '60'];
  String? SelectedPerMatchEstimatedTime;

  List<details>? poolDetails = [];

  bool isLoading = false;

  final EntryFeeController = TextEditingController();
  // final PrizePoolController = TextEditingController();

  final gold = TextEditingController();
  final silver = TextEditingController();
  final bronze = TextEditingController();
  final others = TextEditingController();

  List<Card> AllPools(int count, double deviceWidth, double deviceHeight) {
    List<Card> AllDetails = [];
    for (int i = 0; i < count; i++) {
      var card = Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.01),
        ),
        margin: EdgeInsets.only(
            left: deviceWidth * 0.025, right: deviceWidth * 0.025),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.03, deviceWidth * 0.02, 0, 0),
                child: Text(
                  "${widget.AllCategoryDetails[i].CategoryName} ${widget.AllCategoryDetails[i].AgeCategory}",
                  style: TextStyle(color: Colors.white),
                ),
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
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.06),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    child: Container(
                      height: deviceHeight * 0.06,
                      width: deviceWidth * 0.2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: gold,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            hintText: "Gold",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      height: deviceHeight * 0.06,
                      width: deviceWidth * 0.2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: silver,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            hintText: "Silver",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      height: deviceHeight * 0.06,
                      width: deviceWidth * 0.2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: bronze,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            hintText: "Bronze",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                  ),
                  Align(
                    child: SizedBox(
                      height: deviceHeight * 0.06,
                      width: deviceWidth * 0.2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: others,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.04),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          hintText: "Others",
                          hintStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.02),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.04),
                child: TextField(
                  controller: EntryFeeController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      hintText: "Entry Fee",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
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
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.06),
                      )),
                  value: SelectedPointSystem,
                  items: PointSystems.map((value) => DropdownMenuItem(
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
              Row(),
              Container(
                width: deviceWidth * 0.8,
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    Get.to(WebViewSpots(spots: SelectedPoolSize));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(deviceWidth * 0.06)),
                  ),
                  child: Text(
                    'Preview Fixture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: deviceWidth * 0.8,
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    // EasyLoading.show(
                    //   status: 'Loading...',
                    //   maskType: EasyLoadingMaskType.black,
                    // );
                    if (PoolSizes.isNotEmpty &&
                        EntryFeeController.text.isNotEmpty &&
                        PointSystems.isNotEmpty &&
                        PerMatchEstimatedTime.isNotEmpty &&
                        gold.text.isNotEmpty &&
                        silver.text.isNotEmpty &&
                        bronze.text.isNotEmpty) {
                      var pool = details(
                          PoolSize: SelectedPoolSize!,
                          gold: gold.text,
                          silver: silver.text,
                          bronze: bronze.text,
                          others: others.text,
                          entryfee: EntryFeeController.text,
                          pointsystem: SelectedPointSystem!,
                          PerMatchEstimatedTime:
                              SelectedPerMatchEstimatedTime!);
                      poolDetails?.add(pool);
                      setState(() {
                        String? ok;
                        gold.text = "";
                        silver.text = "";
                        bronze.text = "";
                        SelectedPoolSize = ok;
                        EntryFeeController.text = "";
                        others.text = "";
                        SelectedPointSystem = ok;
                        SelectedPerMatchEstimatedTime = ok;
                      });
                    } else {
                      EasyLoading.showError("All fields are required");
                    }
                  },
                  child: Text(
                    'Submit Category Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(deviceWidth * 0.06)),
                  ),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
            ],
          ),
        ),
      );
      AllDetails.add(card);
    }
    return AllDetails;
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  Widget build(BuildContext context) {
    bool isLoading = false;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover)),
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
                                image:
                                    AssetImage("assets/Ardent_Sport_Text.png"),
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
                Expanded(
                    flex: 1,
                    child: PageView(
                      controller: pageController,
                      children: AllPools(widget.AllCategoryDetails.length,
                          deviceWidth, deviceHeight),
                    )),
                SizedBox(
                  height: 30,
                ),
                DotsIndicator(
                  dotsCount: widget.AllCategoryDetails.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    activeColor: Colors.white,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(
                          deviceWidth * 0.04,
                          deviceWidth * 0.02,
                          deviceWidth * 0.04,
                          deviceWidth * 0.02),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      String poolsize_details = "";
                      String gold_details = "";
                      String silver_details = "";
                      String bronze_details = "";
                      String other_details = "";
                      String entryfee_details = "";
                      String selected_point_system_details = "";
                      String per_match_estimated_time = "";
                      for (int i = 0; i < poolDetails!.length; i++) {
                        poolsize_details += poolDetails![i].PoolSize;
                        gold_details += poolDetails![i].gold;
                        silver_details += poolDetails![i].silver;
                        bronze_details += poolDetails![i].bronze;
                        other_details += poolDetails![i].others;
                        entryfee_details += poolDetails![i].entryfee;
                        selected_point_system_details +=
                            poolDetails![i].pointsystem;
                        per_match_estimated_time +=
                            poolDetails![i].PerMatchEstimatedTime;
                        if (i != poolDetails!.length - 1) {
                          poolsize_details += "-";
                          gold_details += "-";
                          silver_details += "-";
                          bronze_details += "-";
                          other_details += "-";
                          entryfee_details += "-";
                          selected_point_system_details += "-";
                          per_match_estimated_time += "-";
                        }
                      }
                      EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var obtianedEmail = prefs.getString('email');
                      print(obtianedEmail);
                      String Category = "";
                      String AgeCategory = "";
                      for (int i = 0;
                          i < widget.AllCategoryDetails.length;
                          i++) {
                        Category += widget.AllCategoryDetails[i].CategoryName;
                        AgeCategory += widget.AllCategoryDetails[i].AgeCategory;
                        if (i != widget.AllCategoryDetails.length - 1) {
                          Category += "-";
                          AgeCategory += "-";
                        }
                      }
                      print(Category);
                      print(gold_details);
                      print(silver_details);
                      print(bronze_details);
                      print(other_details);
                      print(entryfee_details);
                      print(widget.EventName);
                      print(widget.City);

                      final ChallengeDetails = CreateChallengeDetails(
                          USERID: obtianedEmail!.trim(),
                          TOURNAMENT_ID: "123456",
                          CATEGORY: Category,
                          NO_OF_KNOCKOUT_ROUNDS: poolsize_details,
                          ENTRY_FEE: entryfee_details,
                          GOLD: gold_details,
                          SILVER: silver_details,
                          BRONZE: bronze_details,
                          OTHER: other_details,
                          PRIZE_POOL: "1800-1200-1300",
                          TOURNAMENT_NAME: widget.EventName,
                          CITY: widget.City,
                          TYPE: widget.EventType,
                          LOCATION: widget.Address,
                          START_DATE: widget.StartDate,
                          END_DATE: widget.EndDate,
                          START_TIME: widget.StartTime,
                          END_TIME: widget.EndTime,
                          REGISTRATION_CLOSES_BEFORE: 6,
                          AGE_CATEGORY: AgeCategory,
                          NO_OF_COURTS: widget.NoofCourts,
                          BREAK_TIME: widget.BreakTime,
                          SPORT: widget.SportName);
                      final DetailMap = ChallengeDetails.toMap();
                      final json = jsonEncode(DetailMap);
                      var url =
                          "https://ardentsportsapis.herokuapp.com/createMultipleTournament";

                      try {
                        var response = await post(Uri.parse(url),
                            headers: {
                              "Accept": "application/json",
                              "Content-Type": "application/json"
                            },
                            body: json,
                            encoding: Encoding.getByName("utf-8"));
                        Map<String, dynamic> jsonData =
                            jsonDecode(response.body);
                        debugPrint('Response body:$json');
                        print(jsonData["TOURNAMENT_ID"]);
                        var tournament_id_arr =
                            jsonData["TOURNAMENT_ID"].toString().split(',');
                        if (response.statusCode == 200) {
                          EasyLoading.dismiss();
                          Get.to(CreateChallengeTicket(
                            Tournament_ID: tournament_id_arr,
                            CategorieNames: widget.AllCategoryDetails,
                          ));
                          EasyLoading.dismiss();
                        } else {
                          EasyLoading.dismiss();
                          EasyLoading.showError("Error in Tournament Creation");
                        }
                      } catch (e) {
                        print(e);
                        EasyLoading.showError(e.toString());
                        EasyLoading.dismiss();
                      }
                    },
                    child: Text("Create Tournament",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ));
  }
}
