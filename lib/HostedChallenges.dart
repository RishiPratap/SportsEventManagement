// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:ardent_sports/WebViewTournamentDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HomePage.dart';
import 'PastHostedChallenges.dart';

class HostedChallenges extends StatefulWidget {
  HostedChallenges({Key? key}) : super(key: key);

  @override
  State<HostedChallenges> createState() => _HostedChallengesState();
}

class UserData {
  late String _id;
  late String TOURNAMENT_ID;
  late String TOURNAMENT_NAME;
  late bool STATUS;
  late String LOCATION;
  late String CITY;
  late String TYPE;
  late String START_DATE;
  late String COLOR;
  late String END_DATE;
  late String SPORT;
  late bool CANCELLATION_STATUS;
  late List PARTICIPANTS;
  late int NO_OF_KNOCKOUT_ROUNDS;
  late List SPOT_STATUS_ARRAY;
  late int PRIZE_POOL;
  late int ENTRY_FEE;
  late String IMG_URL;
  late List MATCHES;
  late int __v;
  UserData(
    this._id,
    this.TOURNAMENT_ID,
    this.TOURNAMENT_NAME,
    this.STATUS,
    this.LOCATION,
    this.CITY,
    this.TYPE,
    this.START_DATE,
    this.COLOR,
    this.END_DATE,
    this.SPORT,
    this.CANCELLATION_STATUS,
    this.PARTICIPANTS,
    this.NO_OF_KNOCKOUT_ROUNDS,
    this.SPOT_STATUS_ARRAY,
    this.PRIZE_POOL,
    this.ENTRY_FEE,
    this.IMG_URL,
    this.MATCHES,
    this.__v,
  );

  UserData.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    TOURNAMENT_ID = json['TOURNAMENT_ID'];
    TOURNAMENT_NAME = json['TOURNAMENT_NAME'];
    STATUS = json['STATUS'];
    LOCATION = json['LOCATION'];
    CITY = json['CITY'];
    TYPE = json['TYPE'];
    START_DATE = json['START_DATE'];
    COLOR = json['COLOR'];
    END_DATE = json['END_DATE'];
    SPORT = json['SPORT'];
    CANCELLATION_STATUS = json['CANCELLATION_STATUS'];
    PARTICIPANTS = json['PARTICIPANTS'];
    NO_OF_KNOCKOUT_ROUNDS = json['NO_OF_KNOCKOUT_ROUNDS'];
    SPOT_STATUS_ARRAY = json['SPOT_STATUS_ARRAY'];
    PRIZE_POOL = json['PRIZE_POOL'];
    ENTRY_FEE = json['ENTRY_FEE'];
    IMG_URL = json['IMG_URL'];
    MATCHES = json['MATCHES'];
    __v = json['__v'];
  }
}

class Rules {
  Rules({
    required this.TOURNAMENTID,
    required this.RULES,
  });
  late final String TOURNAMENTID;
  late final String RULES;

  Rules.fromJson(Map<String, dynamic> json) {
    TOURNAMENTID = json['TOURNAMENT_ID'];
    RULES = json['RULES'];
  }

  Map<String, dynamic> toMap() {
    return {
      "TOURNAMENT_ID": this.TOURNAMENTID,
      "RULES": this.RULES,
    };
  }
}

class _HostedChallengesState extends State<HostedChallenges> {
  var futures;
  var futures_past_hosted_challenges;
  List<Card> AllTournaments = [];

  var tounamentID;

  List<Card> getHostedTournaments(List<UserData> userdata, int array_length) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    if (array_length == 0) {
      var card = Card(
        child: Text("You Dont Have Any Hosted Challenges"),
      );
      AllTournaments.add(card);
    } else {
      for (int i = array_length - 1; i >= 0; i--) {
        // bool isStarted = userdata[i].STATUS;
        tounamentID = userdata[i].TOURNAMENT_ID;
        var card = Card(
          margin: EdgeInsets.all(deviceWidth * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
          ),
          elevation: 10,
          color: Colors.white60.withOpacity(0.1),
          child: Column(
            //MAIN COLUMN
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Container(
                margin: EdgeInsets.only(top: deviceWidth * 0.002),
                height: MediaQuery.of(context).size.height * 0.075,
                child: InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {
                      EasyLoading.instance.displayDuration =
                          Duration(milliseconds: 15000);
                      EasyLoading.instance.radius = 15;
                      EasyLoading.showInfo(
                          "Tournament Name : ${userdata[i].TOURNAMENT_NAME}",
                          dismissOnTap: true);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                      ),
                      elevation: 20,
                      color: userdata[i].SPORT == 'Badminton'
                          ? Color(0xff6BB8FF)
                          : Color(0xff03C289),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: deviceWidth * 0.03,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: deviceWidth * 0.1,
                              width: deviceWidth * 0.1,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent.withOpacity(0.6),
                                  backgroundBlendMode: BlendMode.darken),
                              child: Image(
                                image: NetworkImage(userdata[i].IMG_URL),
                                height: deviceWidth * 0.04,
                                width: deviceWidth * 0.04,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userdata[i].TOURNAMENT_NAME.length >= 25
                                      ? userdata[i]
                                              .TOURNAMENT_NAME
                                              .substring(0, 25) +
                                          '...'
                                      : userdata[i].TOURNAMENT_NAME,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: deviceWidth * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: deviceWidth * 0.01,
                                ),
                                Text(
                                  userdata[i].CITY,
                                  style: TextStyle(
                                    fontSize: deviceWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: deviceWidth * 0.018,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.018),
                  ),
                  elevation: 2,
                  color: Color.fromRGBO(0, 0, 0, 0).withOpacity(0.2),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: deviceWidth * 0.07),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    userdata[i].SPORT == 'Badminton'
                                        ? Color(0xff6BB8FF)
                                        : Color(0xff03C289),
                              ),
                              onPressed: () =>
                                  _showSheet(userdata[i].TOURNAMENT_ID),
                              child: Text(
                                "Add/Edit Rules ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                  ),
                  elevation: 1,
                  color: Colors.transparent.withOpacity(0.2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: deviceWidth * 0.07),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/trophy 2.png"),
                                  height: deviceWidth * 0.05,
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.03,
                                ),
                                Text(
                                  "Prize money",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(right: deviceWidth * 0.07),
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: deviceWidth * 0.027,
                                        color: Colors.white),
                                    children: <TextSpan>[
                                  TextSpan(text: "Up to "),
                                  TextSpan(
                                      text: " ₹",
                                      style: TextStyle(
                                        fontSize: deviceWidth * 0.05,
                                      )),
                                  TextSpan(
                                    text: userdata[i].PRIZE_POOL.toString(),
                                    style: TextStyle(
                                        fontSize: deviceWidth * 0.05,
                                        color: Color(0xffE74545),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])))
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(deviceWidth * 0.02),
                    child: Image(
                      image: AssetImage("assets/Location.png"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      EasyLoading.instance.displayDuration =
                          Duration(milliseconds: 15000);
                      EasyLoading.instance.radius = 15;
                      EasyLoading.showInfo(
                          "Tournament Address : ${userdata[i].LOCATION}",
                          dismissOnTap: true);
                    },
                    child: Text(
                      userdata[i].LOCATION.length > 20
                          ? userdata[i].LOCATION.substring(0, 20) + '...'
                          : userdata[i].LOCATION,
                      style: TextStyle(
                          color: Colors.white, fontSize: deviceWidth * 0.03),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(
                          ClipboardData(text: userdata[i].TOURNAMENT_ID))
                      .then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Copied to Clipboard"),
                            duration: Duration(seconds: 1),
                          )));
                },
                icon: Icon(
                  Icons.copy,
                  color: Colors.white,
                ),
                label: Text(
                  "ScorerID: ${userdata[i].TOURNAMENT_ID}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: deviceWidth * 0.03,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: userdata[i].STATUS == true
                            ? () async {
                                final url =
                                    "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/createMatches?TOURNAMENT_ID=${userdata[i].TOURNAMENT_ID}";
                                EasyLoading.show(
                                    status: 'Starting',
                                    maskType: EasyLoadingMaskType.black);
                                var response = await get(Uri.parse(url));
                                if (response.statusCode == 200) {
                                  EasyLoading.dismiss();
                                  const msg =
                                      'Tournament has Successfully Started!';
                                  Fluttertoast.showToast(msg: msg);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Failed to start Tournament");
                                }

                                if (userdata[i].STATUS == false) {
                                  const msg = 'Tournament has Already Started!';
                                  Fluttertoast.showToast(msg: msg);
                                }
                              }
                            : null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Start",
                                style:
                                    TextStyle(fontSize: deviceWidth * 0.0333),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Challenge",
                                style:
                                    TextStyle(fontSize: deviceWidth * 0.0333),
                              ),
                            ),
                          ],
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewTournamentDetails(
                                    Tournament_Id: userdata[i].TOURNAMENT_ID,
                                  )));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Container(
                        child: Center(
                          child: Text(
                            "Details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.033,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.download,
                  color: Colors.red,
                ),
                label: Text(
                  "Download",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  final Uri toLaunch = Uri(
                      scheme: 'https',
                      host: "ardent-api.onrender.com",
                      path: "/download",
                      queryParameters: {
                        'TOURNAMENT_ID': userdata[i].TOURNAMENT_ID,
                      });

                  _launchInBrowser(toLaunch);
                },
              )
            ],
          ),
        );
        AllTournaments.add(card);
      }
    }

    return AllTournaments;
  }

  final rulesController = TextEditingController();

  void _showSheet(String tourneyID) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(bc).size.height * 0.035,
                ),
                Text(
                  "Enter Tournament Rules",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: rulesController,
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your rules here',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                    hintText:
                        " Tournament Rules: \n 1.Umpire decision will be final.\n 2.Mavis 350 Shuttles will be used.",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: rulesController,
                  builder: ((context, value, child) {
                    return ElevatedButton(
                      onPressed: value.text.isNotEmpty
                          ? () {
                              showSheet(tourneyID);
                            }
                          : null,
                      child: Text("Add Rules"),
                    );
                  }),
                )
              ],
            ),
          );
        });
  }

  void showSheet(String tourneyID) async {
    final rules = Rules(RULES: rulesController.text, TOURNAMENTID: tourneyID);
    final rulesMap = rules.toMap();
    final json = jsonEncode(rulesMap);

    print("Tournament ID:$tourneyID");

    EasyLoading.show(
        status: 'Adding Rules', maskType: EasyLoadingMaskType.black);
    var response = await post(
        Uri.parse(
            "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/rules"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json,
        encoding: Encoding.getByName("utf-8"));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['Message'] == 'Success') {
      EasyLoading.dismiss();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Rules Added Successfully");
    } else {
      EasyLoading.dismiss();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Failed to add Rules");
    }
  }

  getAllHostedTournaments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtianedEmail = prefs.getString('email');
    var url =
        "hhttp://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/hostedTournaments?USERID=$obtianedEmail";
    var response = await get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);

    print(jsonData);
    try {
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      int array_length = userdata.length;
      print(userdata);
      getAllPastHostedTournaments();
      return getHostedTournaments(userdata, array_length);
    } catch (e) {
      print(e);
    }
  }

  getAllPastHostedTournaments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtianedEmail = prefs.getString('email');
    var url =
        "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/pastTournaments?USERID=$obtianedEmail";
    var response = await get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);

    print(jsonData);
    try {
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      int array_length = userdata.length;
      print(userdata);
      return getHostedTournaments(userdata, array_length);
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    futures = getAllHostedTournaments();

    // futures_past_hosted_challenges = getAllPastHostedTournaments();
  }

  Future<Null> _refreshScreen() async {
    Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (a, b, c) => HostedChallenges()));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool isStarted = false;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return false;
      },
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          onRefresh: () => _refreshScreen(),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ///USE EXPANDED HERE TO DEBUG
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: deviceWidth * 0.2,
                                height: deviceHeight * 0.07,
                                margin: EdgeInsets.fromLTRB(
                                    0, deviceWidth * 0.03, 0, 0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage('assets/AARDENT_LOGO.png'),
                                  fit: BoxFit.cover,
                                )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  //USE EXPANDED HERE TO DEBUG
                                  width: deviceWidth * 0.2,
                                  height: deviceHeight * 0.08,
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
                                  //USE EXPANDED HERE TO DEBUG
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: deviceWidth * 0.06,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.03, 0, 0, 0),
                            child: const Text(
                              "Upcoming Hosted Challenges",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                        SizedBox(
                          height: deviceWidth * 0.05,
                        ),
                        FutureBuilder(
                          future: futures,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.data == null) {
                              print("In Null");
                              return Container(
                                child: Center(
                                  child: Text(
                                      "You Dont Have any Hosted Challenges"),
                                ),
                              );
                            } else {
                              return Column(
                                children: snapshot.data,
                              );
                            }
                          },
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.03, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Get.to(PastHostedChallenges());
                              },
                              child: Text(
                                "Past Hosted Challenges >",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )),
                        // FutureBuilder(
                        //   future: getAllPastHostedTournaments(),
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<dynamic> snapshot) {
                        //     if (snapshot.data == null) {
                        //       print("In Null");
                        //       return Container(
                        //         child: Center(
                        //           child: Text(
                        //               "You Dont Have any past hosted challenges"),
                        //         ),
                        //       );
                        //     } else {
                        //       return Column(
                        //         children: snapshot.data,
                        //       );
                        //     }
                        //   },
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
