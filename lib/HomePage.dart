import 'dart:convert';
import 'dart:ffi';
import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'Menu.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
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
    MATCHES = json['MATCHES'];
    __v = json['__v'];
  }
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();
  List<Container> AllTournaments = [];
  final url = 'https://ardentsportsapis.herokuapp.com/allTournaments';
  List<Container> getTournaments(List<UserData> userdata, int array_length) {
    for (int i = 0; i < array_length; i++) {
      var container = Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          color: Colors.white60.withOpacity(0.1),
          child: Column(
            //MAIN COLUMN
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Container(
                margin: EdgeInsets.only(top: 2),
                height: MediaQuery.of(context).size.height * 0.075,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BadmintonSpotSelection()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 20,
                    color: Color(0xff6BB8FF),
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent.withOpacity(0.6),
                                backgroundBlendMode: BlendMode.darken),
                            child: Image(
                              image: AssetImage("assets/badminton.png"),
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userdata[i].TOURNAMENT_NAME,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                userdata[i].CITY,
                                style: TextStyle(
                                  fontSize: 13,
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
                height: 7,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 1,
                  color: Colors.transparent.withOpacity(0.2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 35),
                            child: Text(
                              "Category",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            onPressed: () {
                              userData();
                            },
                            child: Text(
                              "V",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffE74545),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(right: 35),
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
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 1,
                  color: Colors.transparent.withOpacity(0.2),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 35),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/trophy 2.png"),
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 15,
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
                            margin: EdgeInsets.only(right: 35),
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    children: <TextSpan>[
                                  TextSpan(text: "Up to "),
                                  TextSpan(
                                      text: " ₹",
                                      style: TextStyle(
                                        fontSize: 25,
                                      )),
                                  TextSpan(
                                    text: userdata[i].PRIZE_POOL.toString(),
                                    style: TextStyle(
                                        fontSize: 25,
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
                    padding: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage("assets/Location.png"),
                    ),
                  ),
                  Text(
                    userdata[i].LOCATION,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      );
      AllTournaments.add(container);
    }
    return AllTournaments;
  }

  getAllTournaments() async {
    var response = await get(Uri.parse(url));
    List<dynamic> jsonData = jsonDecode(response.body);
    print(jsonData);
    List<UserData> userdata =
        jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
    int array_length = userdata.length;
    return getTournaments(userdata, array_length);
  }

  void userData() async {
    try {
      var response = await get(Uri.parse(url));
      List<dynamic> jsonData = jsonDecode(response.body);
      print("1");
      print(jsonData);
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      print(userdata[0].SPORT);
    } catch (err) {
      print("ok");
      print(err);
    }
  }

  @override
  void initState() {
    // userData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
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
                            width: 90,
                            height: 50,
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
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu()));
                            },
                            child: Container(
                              width: 20,
                              height: 16,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/menu_bar.png"),
                                      fit: BoxFit.fitHeight)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/Profile_Image.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/money_bag.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text("Shubham"),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Text("₹15,000"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                      future: getAllTournaments(),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
