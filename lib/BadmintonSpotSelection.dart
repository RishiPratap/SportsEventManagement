// ignore: file_names
// ignore: camel_case_types
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ardent_sports/MyBookings.dart';
import 'package:ardent_sports/SpotConfirmation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

int freespots = 0;
int entryfee = 0;
int prizepool = 0;
var array1 = [];
String? finalEmail;
Timer? timer;

class BadmintonSpotSelection extends StatefulWidget {
  final String tourneyId;
  final String sport;
  const BadmintonSpotSelection({
    Key? key,
    required this.tourneyId,
    required this.sport,
  }) : super(key: key);

  @override
  State<BadmintonSpotSelection> createState() => _BadmintonSpotSelectionState();
}

late Color color1 = Color(0xffffff00).withOpacity(0.8);

class tournament_id {
  late String TOURNAMENT_ID;
  tournament_id({required this.TOURNAMENT_ID});
  Map<String, dynamic> toMap() {
    return {"TOURNAMENT_ID": this.TOURNAMENT_ID};
  }
}

class SpotClickedDetails {
  late String TOURNAMENT_ID;
  late String index;
  String? USER;

  SpotClickedDetails(
      {required this.TOURNAMENT_ID, required this.index, required this.USER});
  Map<String, dynamic> toMap() {
    return {
      "TOURNAMENT_ID": this.TOURNAMENT_ID,
      "btnID": this.index,
      "USERID": this.USER
    };
  }
}

class json_decode_spotstatusarray {
  late int total_no_spots;
  var array = [];
  late int Prize_Pool;
  late int entry_fee;
  json_decode_spotstatusarray(
      this.total_no_spots, this.array, this.Prize_Pool, this.entry_fee);
  json_decode_spotstatusarray.fromJson(Map<String, dynamic> json) {
    total_no_spots = json['total_spots'];
    array = json['array'];
    Prize_Pool = json['prize_pool'];
    entry_fee = json['entry_fee'];
  }
}

class json_decode_spot_clicked_return {
  late String spot_number;
  late String color;
  json_decode_spot_clicked_return(this.spot_number, this.color);
  json_decode_spot_clicked_return.fromJson(Map<String, dynamic> json) {
    spot_number = json['btnID'];
    color = json['color'];
  }
}

class json_decode_confirm_clicked_return {
  late String spot_number;
  json_decode_confirm_clicked_return(this.spot_number);
  json_decode_confirm_clicked_return.fromJson(Map<String, dynamic> json) {
    spot_number = json['btnID'];
  }
}

class send_socket_number_ {
  late String spot_number;
  late String tourney_id;
  String? USER_ID;

  send_socket_number_(this.spot_number, this.tourney_id, this.USER_ID);
  Map<String, dynamic> toMap() {
    return {
      "TOURNAMENT_ID": this.tourney_id,
      "SPOTID": this.spot_number,
      "USERID": this.USER_ID,
    };
  }
}

class _BadmintonSpotSelectionState extends State<BadmintonSpotSelection> {
  int totalspots = 0;
  var count = 0;
  var isTournamentBooked = false;
  late Socket socket;
  @override
  List<Container> getTotalSpots(int start, int end, List<dynamic> array) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<Container> totalspots = [];
    for (int i = start; i <= end; i++) {
      String x = array[i - 1];
      String spotname = "Spot $i";
      if (array[i - 1] == "${i - 1}") {
        var newContainer = Container(
          margin: EdgeInsets.only(top: deviceWidth * 0.02),
          width: deviceWidth * 0.2,
          height: deviceWidth * 0.07,
          child: RaisedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var obtianedEmail = prefs.getString('email');

              debugPrint("EmailFromSocket: $finalEmail");
              debugPrint("tournamentIDDDDDD:${widget.tourneyId}");
              final tournament_id1 = SpotClickedDetails(
                TOURNAMENT_ID: widget.tourneyId,
                index: (i - 1).toString(),
                USER: obtianedEmail,
              );
              final tournament_id1Map = tournament_id1.toMap();

              final json_tournamentid = jsonEncode(tournament_id1Map);

              if (!isTournamentBooked) {
                socket.emit('spot-clicked', json_tournamentid);
                print(widget.sport);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: SpotConfirmation(
                      SpotNo: i.toString(),
                      Date: "21/11/21",
                      socket: socket,
                      btnId: (i - 1).toString(),
                      tournament_id: widget.tourneyId,
                      userEmail: obtianedEmail!,
                      sport: widget.sport,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title:
                        const Text("You Have Already Booked this Tournament"),
                    content: const Text("Do you want to go to my booking?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "NO",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      //one min
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: MyBookings()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("YES",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // SOCKET ON
              socket.on('spot-clicked-return', (data) {
                Map<String, dynamic> spot_cliclked_return_details =
                    jsonDecode(data);
                var details = json_decode_spot_clicked_return
                    .fromJson(spot_cliclked_return_details);
                String spotnumber = details.spot_number;
                var timer = 25;
                final socket_number = send_socket_number_(
                    spotnumber, widget.tourneyId, finalEmail);
                print(spotnumber);
                final socket_number_map = socket_number.toMap();
                final json_socket_number = jsonEncode(socket_number_map);

                setState(() {
                  array1[int.parse(spotnumber)] = "${finalEmail}";
                  debugPrint("Array:$array1");
                });
              });
            },
            color: Color(0xff6EBC55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(deviceWidth * 0.01),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: deviceWidth * 0.03),
            ),
          ),
        );
        totalspots.add(newContainer);
      } else if (x.contains('confirmed')) {
        var newContainer = Container(
          margin: EdgeInsets.only(top: deviceWidth * 0.02),
          width: deviceWidth * 0.2,
          height: deviceWidth * 0.07,
          child: RaisedButton(
            onPressed: () {
              const msg = "Spot Already Booked Please Try To Book Another Spot";
              Fluttertoast.showToast(
                  msg: msg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: deviceWidth * 0.033);
            },
            color: Color(0xff808080),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(deviceWidth * 0.01),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: deviceWidth * 0.03),
            ),
          ),
        );
        totalspots.add(newContainer);
      } else {
        var newContainer = Container(
          margin: EdgeInsets.only(top: deviceWidth * 0.02),
          width: deviceWidth * 0.2,
          height: deviceWidth * 0.07,
          child: RaisedButton(
            onPressed: () {
              final msg =
                  'Someone is currently booking the spot please try to book another spot or wait for some-time';
              Fluttertoast.showToast(msg: msg);
            },
            color: Color(0xffFFFF00).withOpacity(0.8),
            key: Key(color1.toString()),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(deviceWidth * 0.01),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: deviceWidth * 0.03),
            ),
          ),
        );
        totalspots.add(newContainer);
      }
    }
    return totalspots;
  }

  connect(double deviceWidth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtianedEmail = prefs.getString('email');
    bool isBooked = false;
    socket.on('spot-clicked-return', (data) {
      Map<String, dynamic> spot_cliclked_return_details = jsonDecode(data);
      var details = json_decode_spot_clicked_return
          .fromJson(spot_cliclked_return_details);
      String spotnumber = details.spot_number;
      var timer = 30;
      final socket_number =
          send_socket_number_(spotnumber, widget.tourneyId, finalEmail);
      print(spotnumber);
      final socket_number_map = socket_number.toMap();
      final json_socket_number = jsonEncode(socket_number_map);
      if (mounted) {
        setState(() {
          array1[int.parse(spotnumber)] = "${finalEmail}";
          super.deactivate();
        });
      }
    });
    socket.on('booking-confirmed', (data) {
      Map<String, dynamic> booking_confirmed_details = jsonDecode(data);
      var booking_details = json_decode_confirm_clicked_return
          .fromJson(booking_confirmed_details);
      String spotnumber = booking_details.spot_number;
      print("okok${spotnumber}");
      if (mounted) {
        setState(() {
          array1[int.parse(spotnumber)] = "confirmed-$finalEmail";
          super.deactivate();
        });
      }
    });
    socket.on('removed-from-waiting-list', (data) {
      print("removed from waiting list");
      setState(() {
        if (mounted) {
          setState(() {
            array1[int.parse(data['btnID'])] = data['btnID'];
            super.deactivate();
          });
        }
      });
    });
    socket.on('spotStatusArray', (data) {
      Map<String, dynamic> spot_details = jsonDecode(data);
      var details = json_decode_spotstatusarray.fromJson(spot_details);
      totalspots = details.total_no_spots;
      array1 = details.array;
      prizepool = details.Prize_Pool;
      entryfee = details.entry_fee;
      freespots = 0;
      bool isBooked = false;
      for (int i = 0; i < totalspots; i++) {
        if (array1[i] == "confirmed-$obtianedEmail") {
          isBooked = true;
        }
        if (array1[i] == "$i") {
          freespots = freespots + 1;
        }
      }
      if (count == 0) {
        if (mounted) {
          setState(() {
            count = 1;
            isTournamentBooked = isBooked;
            super.deactivate();
          });
        }
      }
    });

    print("is${array1}");
    return Column(
      children: [
        SizedBox(
          height: deviceWidth * 0.04,
        ),
        Container(
          margin: EdgeInsets.only(
              left: deviceWidth * 0.05, right: deviceWidth * 0.05),
          child: buildSpotsAvailableCard(deviceWidth),
        ),
        Container(
          margin: EdgeInsets.only(
              left: deviceWidth * 0.05, right: deviceWidth * 0.05),
          child: buildAvailableSpotsCard(deviceWidth),
        ),
      ],
    );
  }

  //http://ardentsportsapis-env.eba-wixhrshv.ap-south-1.elasticbeanstalk.com/
  var futures;
  void initState() {
    socket = io("https://ardentsportsapis.herokuapp.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    final tournament_id1 = tournament_id(TOURNAMENT_ID: widget.tourneyId);
    final tournament_id1Map = tournament_id1.toMap();
    final json_tournamentid = jsonEncode(tournament_id1Map);
    if (mounted) {
      socket.emit('join-booking', json_tournamentid);
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Exit Alert"),
            content: const Text("Are you sure you want to exit?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "NO",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child:
                      const Text("YES", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future: connect(deviceWidth),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: Text("Loading..."),
                          ),
                        );
                      } else {
                        return Column(
                          children: snapshot.data.children,
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
    );
  }

  Widget buildSpotsAvailableCard(double deviceWidth) => Card(
        elevation: 10,
        color: Color(0xff03c289),
        child: Row(
          children: [
            SizedBox(
              width: deviceWidth * 0.02,
            ),
            Column(
              children: [
                Text(
                  "Prize Pool",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: deviceWidth * 0.03,
                  ),
                ),
                Container(
                  width: deviceWidth * 0.25,
                  height: deviceWidth * 0.07,
                  child: Card(
                    elevation: 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0)),
                    color: Colors.black.withOpacity(0.25),
                    child: Text(
                      "₹$prizepool",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: deviceWidth * 0.05,
            ),
            Column(
              children: [
                Text(
                  "Men's Single",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: deviceWidth * 0.03,
                  ),
                ),
                Text(
                  "Draw",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: deviceWidth * 0.03,
                  ),
                ),
                Container(
                  width: deviceWidth * 0.25,
                  height: deviceWidth * 0.07,
                  child: Card(
                    elevation: 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0)),
                    color: Colors.black.withOpacity(0.25),
                    child: Text(
                      "$freespots/$totalspots",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: deviceWidth * 0.09,
            ),
            Column(
              children: [
                Text(
                  "Entry Fees",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: deviceWidth * 0.03,
                  ),
                ),
                Container(
                  width: deviceWidth * 0.15,
                  height: deviceWidth * 0.07,
                  child: Card(
                    elevation: 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0)),
                    color: Colors.black.withOpacity(0.25),
                    child: Text(
                      "₹$entryfee",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
  Widget buildAvailableSpotsCard(double deviceWidth) => Card(
        elevation: 10,
        color: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth * 0.04,
                  height: deviceWidth * 0.04,
                  color: Color(0xff6EBC55),
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text("Vacant"),
                SizedBox(
                  width: deviceWidth * 0.06,
                ),
                Container(
                  width: deviceWidth * 0.04,
                  height: deviceWidth * 0.04,
                  color: Color(0xff808080),
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text("Booked"),
                SizedBox(
                  width: deviceWidth * 0.06,
                ),
                Container(
                  width: deviceWidth * 0.04,
                  height: deviceWidth * 0.04,
                  color: Color(0xffFFFF00).withOpacity(0.8),
                ),
                Text("   Processing"),
              ],
            ),
            SizedBox(
              height: deviceWidth * 0.03,
            ),
            Row(children: [
              SizedBox(
                width: deviceWidth * 0.05,
                height: deviceWidth * 0.06,
              ),
              Column(
                children: getTotalSpots(1, (totalspots / 2).toInt(), array1),
              ),
              SizedBox(
                width: deviceWidth * 0.4,
                height: deviceWidth * 0.24,
              ),
              Column(
                children: getTotalSpots(
                    (totalspots / 2).toInt() + 1, totalspots, array1),
              ),
            ]),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(left: deviceWidth * 0.06),
              child: Text(
                "Note :",
                style: TextStyle(color: Color(0xffD15858)),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(left: deviceWidth * 0.05),
              child: Text(
                "Matches Will be played according to the draws shown above,so please select your spot accordingly",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(left: deviceWidth * 0.05),
              child: Text(
                "Spots Cannot be changed once selected",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
          ],
        ),
      );
}
