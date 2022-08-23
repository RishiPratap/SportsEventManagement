import 'dart:convert';
import 'package:ardent_sports/WebViewTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'package:get/get.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookings();
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

class _MyBookings extends State<MyBookings> {
  var futures;
  List<Container> AllUpcomingHostedTournaments = [];

  List<Container> AllTournaments = [];

  List<Container> getHostedTournaments(
      List<UserData> userdata, int array_length) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    if (array_length == 0) {
      var container = Container(
        margin: EdgeInsets.fromLTRB(deviceWidth * 0.03, 0, 0, 0),
        child: Text("You Do not have any Bookings"),
      );
      AllTournaments.add(container);
    } else {
      for (int i = array_length - 1; i >= 0; i--) {
        var container = Container(
          height: MediaQuery.of(context).size.height * 0.38,
          padding: EdgeInsets.all(deviceWidth * 0.018),
          child: Card(
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
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BadmintonSpotSelection(
                      //           tourneyId: userdata[i].TOURNAMENT_ID,
                      //         )));
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
                        margin: EdgeInsets.only(top: deviceWidth * 0.021),
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
                              children: [
                                Text(
                                  userdata[i].TOURNAMENT_NAME.length >= 17
                                      ? userdata[i]
                                              .TOURNAMENT_NAME
                                              .substring(0, 15) +
                                          '...'
                                      : userdata[i].TOURNAMENT_NAME,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: deviceWidth * 0.027,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: deviceWidth * 0.01,
                                ),
                                Text(
                                  userdata[i].CITY,
                                  style: TextStyle(
                                    fontSize: deviceWidth * 0.027,
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
                )),
                SizedBox(
                  height: deviceWidth * 0.018,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.018),
                    ),
                    elevation: 1,
                    color: Colors.transparent.withOpacity(0.2),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: deviceWidth * 0.07),
                              child: Text(
                                "Category",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "V",
                                style: TextStyle(
                                  fontSize: deviceWidth * 0.04,
                                  color: Color(0xffE74545),
                                ),
                              )),
                          Container(
                              margin:
                                  EdgeInsets.only(right: deviceWidth * 0.07),
                              child: Text(
                                "Spots Left",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
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
                              margin:
                                  EdgeInsets.only(right: deviceWidth * 0.07),
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
                    Text(
                      userdata[i].LOCATION,
                      style: TextStyle(
                          color: Colors.white, fontSize: deviceWidth * 0.03),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: const Color(0xffE74545),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Ticket >",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceWidth * 0.03,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: const Color(0xffE74545),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            var id = prefs.getString('email');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewTest(
                                  userId: id,
                                  Tourney_id: userdata[i].TOURNAMENT_ID,
                                ),
                              ),
                            );
                          },
                          child: Text("View Fixtures >",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceWidth * 0.03,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
        AllTournaments.add(container);
      }
    }
    return AllTournaments;
  }

  getAllHostedTournaments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtianedEmail = prefs.getString('email');
    var url =
        "https://ardentsportsapis.herokuapp.com/myBookings?USERID=$obtianedEmail";
    var response = await get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Didn't Receive");
    }
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
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Homepage.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: deviceWidth * 0.18,
                            height: deviceWidth * 0.1,
                            margin: EdgeInsets.fromLTRB(
                                0, deviceWidth * 0.03, 0, 0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/AARDENT_LOGO.png'),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: deviceWidth * 0.026,
                            height: deviceWidth * 0.08,
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
                      height: deviceWidth * 0.06,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.04))),
                        onPressed: () {
                          Get.to(HomePage());
                        },
                        child: Text(
                          "Join a Tournament",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceWidth * 0.03),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.03, 0, 0, 0),
                            child: Text("My Bookings")),
                        FutureBuilder(
                          future: futures,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.data == null) {
                              print("In Null");
                              return Container(
                                child: Center(
                                  child: Text("Loading..."),
                                ),
                              );
                            } else {
                              return Column(
                                children: snapshot.data,
                              );
                            }
                          },
                        ),
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
