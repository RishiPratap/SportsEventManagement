import 'dart:async';
import 'dart:convert';
import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'Menu.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'Profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class SpotStatusArray {
  late String category;
  late String id;
  late List array;
  SpotStatusArray(
    this.category,
    this.id,
    this.array,
  );
  SpotStatusArray.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    array = json[array];
  }
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
  late String START_TIME;
  late String END_TIME;
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
  late List spotStatusArray;
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
    this.START_TIME,
    this.END_TIME,
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
    this.spotStatusArray,
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
    START_TIME = json['START_TIME'];
    END_TIME = json['END_TIME'];
    SPORT = json['SPORT'];
    CANCELLATION_STATUS = json['CANCELLATION_STATUS'];
    PARTICIPANTS = ['PARTICIPANTS'];
    NO_OF_KNOCKOUT_ROUNDS = json['NO_OF_KNOCKOUT_ROUNDS'];
    SPOT_STATUS_ARRAY = json['SPOT_STATUS_ARRAY'];
    PRIZE_POOL = json['PRIZE_POOL'];
    ENTRY_FEE = json['ENTRY_FEE'];
    IMG_URL = json['IMG_URL'];
    MATCHES = json['MATCHES'];
    __v = json['__v'];
    spotStatusArray = json['spotStatusArrays'];
  }
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();
  List<Card> AllTournaments = [];

  final url = 'https://ardentsportsapis.herokuapp.com/baseTournaments';

  List<Card> getTournaments(List<UserData> userdata, int array_length) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    for (int i = array_length - 1; i >= 0; i--) {
      var container = Card(
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
                onTap: () async {},
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
                          height: deviceHeight * 0.1,
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
                              userdata[i].TOURNAMENT_NAME.length >= 13
                                  ? userdata[i]
                                          .TOURNAMENT_NAME
                                          .substring(0, 13) +
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
              height: deviceHeight * 0.012,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(deviceWidth * 0.04),
              ),
              elevation: 1,
              color: Colors.transparent.withOpacity(0.2),
              child: Container(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: deviceWidth * 0.02),
                          child: Text(
                            "Category",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                          onPressed: () {
                            //userData();
                          },
                          child: Text(
                            "V",
                            style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                              color: Color(0xffE74545),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(right: deviceWidth * 0.02),
                        child: Text(
                          "Spots Left",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  children: getAllTournamentCategories(
                      userdata[i].spotStatusArray, userdata[i].START_DATE),
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
                              const Text(
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
                Text(
                  userdata[i].LOCATION.length > 20
                      ? userdata[i].LOCATION.substring(0, 12) + '...'
                      : userdata[i].LOCATION,
                  style: TextStyle(
                      color: Colors.white, fontSize: deviceWidth * 0.03),
                ),
                Flexible(fit: FlexFit.tight, child: SizedBox()),
                Container(
                  padding: EdgeInsets.all(deviceWidth * 0.02),
                  margin: EdgeInsets.only(right: deviceWidth * 0.08),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.red),
                      SizedBox(
                        width: deviceWidth * 0.02,
                      ),
                      Column(
                        children: [
                          Text(
                            userdata[i].START_DATE,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${(userdata[i].START_TIME)} - ${(userdata[i].END_TIME)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
      AllTournaments.add(container);
    }
    return AllTournaments;
  }

  List<Container> getAllTournamentCategories(
      List spotStatusArray, String Date) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<Container> AllCategories = [];
    int array_length = spotStatusArray.length;
    for (int i = 0; i < array_length; i++) {
      int x = spotStatusArray[i]['array'].length;
      int y = 0;
      for (int j = 0; j < x; j++) {
        if (spotStatusArray[i]['array'][j] == "$j") {
          y++;
        }
      }
      var container = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: InkWell(
                onTap: () async {
                  EasyLoading.show(
                      status: 'Loading...',
                      indicator: SpinKitThreeBounce(
                        color: Color(0xFFE74545),
                      ),
                      maskType: EasyLoadingMaskType.black);
                  var url =
                      "http://44.202.65.121:443/isTimeExceeded?TOURNAMENT_ID=${spotStatusArray[i]['id']}";
                  var response = await get(Uri.parse(url));

                  Map<String, dynamic> jsonData = jsonDecode(response.body);
                  if (jsonData['Message'] == "false" &&
                      spotStatusArray[i]['STATUS'] == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadmintonSpotSelection(
                                  tourneyId: spotStatusArray[i]['id'],
                                  sport: spotStatusArray[i]['SPORT'],
                                  Date: Date,
                                )));
                    EasyLoading.dismiss();
                  } else if (spotStatusArray[i]['STATUS'] == false) {
                    EasyLoading.showError(
                        "Tournament has been completed. You can't join this tournament anymore");
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text("Time Exceeded!"),
                              content: const Text(
                                  "This Tournament Booking time has been exceeded"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),

                                //one min
                              ],
                            ));
                    EasyLoading.dismiss();
                    print("Time Exceeded");
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(left: deviceWidth * 0.02),
                    height: deviceHeight * 0.03,
                    width: deviceWidth * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: new Center(
                      child: new Text(
                        spotStatusArray[i]['category'],
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "$y/$x",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
      AllCategories.add(container);
    }
    return AllCategories;
  }

  // _convertTime(time) {
  //   DateFormat("h:mm a").format(DateTime.parse(time));
  // }

  getAllTournaments() async {
    var response = await get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);
    try {
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      int array_length = userdata.length;
      print(userdata);
      return getTournaments(userdata, array_length);
    } catch (e) {
      print(e);
    }
  }

  void userData() async {
    try {
      var response = await get(Uri.parse(url));
      List<dynamic> jsonData = jsonDecode(response.body);

      print(jsonData);
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      print(userdata[0].SPORT);
    } catch (err) {
      print("error");
      print(err);
    }
  }

  Map? mapUserInfo;

  Future _getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    final uri = 'http://44.202.65.121:443/userDetails?USERID=${email!.trim()}';

    http.Response response;
    response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      setState(() {
        mapUserInfo = json.decode(response.body);
      });
    }
  }

  var futures;
  @override
  void initState() {
    super.initState();

    futures = getAllTournaments();
    _getDetails();
    // userData();
  }

  Future<Null> _refreshTournaments() async {
    Navigator.pushReplacement(
        context, PageRouteBuilder(pageBuilder: (a, b, c) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          onRefresh: () => _refreshTournaments(),
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
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: deviceWidth * 0.2,
                              height: deviceHeight * 0.07,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/AARDENT_LOGO.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.2,
                              height: deviceHeight * 0.08,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/Ardent_Sport_Text.png"),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => Menu());
                          },
                          child: Container(
                            width: deviceWidth * 0.1,
                            height: deviceHeight * 0.02,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/menu_bar.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("pressed");
                            Get.to(Profile(
                              name: mapUserInfo?['Name'],
                              points: mapUserInfo?['Points'],
                            ));
                          },
                          child: Container(
                            width: deviceWidth * 0.08,
                            height: deviceHeight * 0.05,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/Profile_Image.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                        ),
                        Container(
                          width: deviceWidth * 0.08,
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: deviceWidth * 0.01),
                          child: Center(
                              child: Text(
                                  "${mapUserInfo == null ? "Loading.." : mapUserInfo?['Name']}")),
                        ),
                        Container(
                          width: double.infinity,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: deviceWidth * 0.03),
                          child: Text(""),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                      future: futures,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.data == null) {
                          print("In Null");
                          return Container(
                            child: const Center(
                              child: CircularProgressIndicator(),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
