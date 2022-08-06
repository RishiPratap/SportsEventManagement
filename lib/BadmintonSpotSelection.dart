import 'dart:async';
import 'dart:convert';
import 'package:ardent_sports/SpotConfirmation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

int freespots = 0;
int entryfee = 0;
int prizepool = 0;
var array1 = [];
String? finalEmail;

class BadmintonSpotSelection extends StatefulWidget {
  final String tourneyId;
  const BadmintonSpotSelection({
    Key? key,
    required this.tourneyId,
  }) : super(key: key);

  @override
  State<BadmintonSpotSelection> createState() => _BadmintonSpotSelectionState();
}

late Color color1 = Color(0xffFFFF00).withOpacity(0.8);

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
  late Socket socket;

  @override
  List<Container> getTotalSpots(int start, int end, List<dynamic> array) {
    List<Container> totalspots = [];
    for (int i = start; i <= end; i++) {
      String x = array[i - 1];
      String spotname = "Spot $i";
      if (array[i - 1] == "${i - 1}") {
        var newContainer = Container(
          margin: EdgeInsets.only(top: 10),
          width: 70,
          height: 25,
          child: RaisedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var obtianedEmail = prefs.getString('email');
              if (mounted) {
                setState(() {
                  finalEmail = obtianedEmail;
                });
              }

              debugPrint("EmailFromSocket: $finalEmail");
              debugPrint("tournamentIDDDDDD:${widget.tourneyId}");
              final tournament_id1 = SpotClickedDetails(
                TOURNAMENT_ID: widget.tourneyId,
                index: (i - 1).toString(),
                USER: finalEmail,
              );
              final tournament_id1Map = tournament_id1.toMap();
              final json_tournamentid = jsonEncode(tournament_id1Map);
              socket.emit('spot-clicked', json_tournamentid);

              //SOCKET ON
              // socket.on('spot-clicked-return', (data) {
              //   Map<String, dynamic> spot_cliclked_return_details =
              //       jsonDecode(data);
              //   var details = json_decode_spot_clicked_return
              //       .fromJson(spot_cliclked_return_details);
              //   String spotnumber = details.spot_number;
              //   var timer = 25;
              //   final socket_number =
              //       send_socket_number_(spotnumber, "123456", finalEmail);
              //   print(spotnumber);
              //   final socket_number_map = socket_number.toMap();
              //   final json_socket_number = jsonEncode(socket_number_map);
              //   if (color1 == const Color(0xffFFFF00).withOpacity(0.8)) {
              //     Timer.periodic(Duration(seconds: timer), (timer) {
              //       socket.emit('remove-booking', json_socket_number);
              //       debugPrint("removed:$spotnumber");
              //       timer.cancel();
              //     });
              //   }

              //   socket.on('removed-from-waiting-list', (data) {
              //     if (mounted) {
              //       setState(() {});
              //     }
              //   });
              //   if (mounted) {
              //     setState(() {
              //       array1[int.parse(spotnumber)] = "${socket.id}";
              //     });
              //   }
              // });

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
                    userEmail: finalEmail,
                  ),
                ),
              );
            },
            color: Color(0xff6EBC55),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: 10),
            ),
          ),
        );
        totalspots.add(newContainer);
      } else if (x.contains('confirmed')) {
        var newContainer = Container(
          margin: EdgeInsets.only(top: 10),
          width: 70,
          height: 25,
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
                  fontSize: 16.0);
            },
            color: Color(0xff808080),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: 10),
            ),
          ),
        );
        totalspots.add(newContainer);
      } else {
        var newContainer = Container(
          margin: EdgeInsets.only(top: 10),
          width: 70,
          height: 25,
          child: RaisedButton(
            onPressed: () {
              final msg =
                  'Someone is currently booking the spot please try to book another spot or wait for some-time';
              Fluttertoast.showToast(msg: msg);
            },
            color: Color(0xffFFFF00).withOpacity(0.8),
            key: Key(color1.toString()),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text(
              spotname,
              style: TextStyle(fontSize: 10),
            ),
          ),
        );
        totalspots.add(newContainer);
      }
    }
    return totalspots;
  }

  connect() async {
    final tournament_id1 = tournament_id(TOURNAMENT_ID: widget.tourneyId);
    final tournament_id1Map = tournament_id1.toMap();
    final json_tournamentid = jsonEncode(tournament_id1Map);
    socket.emit('join-booking', json_tournamentid);

    socket.on('spot-clicked-return', (data) {
      Map<String, dynamic> spot_cliclked_return_details = jsonDecode(data);
      var details = json_decode_spot_clicked_return
          .fromJson(spot_cliclked_return_details);
      String spotnumber = details.spot_number;
      var timer = 25;
      final socket_number =
          send_socket_number_(spotnumber, widget.tourneyId, finalEmail);
      print(spotnumber);
      final socket_number_map = socket_number.toMap();
      final json_socket_number = jsonEncode(socket_number_map);
      if (color1 == const Color(0xffFFFF00).withOpacity(0.8)) {
        Timer.periodic(Duration(seconds: timer), (timer) {
          socket.emit('remove-booking', json_socket_number);
          debugPrint("removed:$spotnumber");
          timer.cancel();
        });
      }

      socket.on('removed-from-waiting-list', (data) {
        if (mounted) {
          setState(() {});
        }
      });
      if (mounted) {
        setState(() {
          array1[int.parse(spotnumber)] = "${socket.id}";
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
          array1[int.parse(spotnumber)] = "confirmed-${socket.id}";
        });
      }
    });
    socket.on('spotStatusArray', (data) {
      Map<String, dynamic> spot_details = jsonDecode(data);
      var details = json_decode_spotstatusarray.fromJson(spot_details);
      totalspots = details.total_no_spots;
      array1 = details.array;
      prizepool = details.Prize_Pool;
      entryfee = details.entry_fee;
      freespots = 0;
      for (int i = 0; i < totalspots; i++) {
        if (array1[i] == "$i") {
          freespots = freespots + 1;
        }
      }

      if (count == 0) {
        if (!mounted) return;
        setState(() {
          count++;
        });
      }
    });

    print("is${array1}");
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: buildSpotsAvailableCard(),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: buildAvailableSpotsCard(),
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

    // futures = connect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
            child: FutureBuilder(
              future: connect(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) {
                  print("In Null agar hua toh mar khayega");
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
          ),
        ),
      ),
    );
  }

  Widget buildSpotsAvailableCard() => Card(
        elevation: 10,
        color: Color(0xff03c289),
        child: Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Column(
              children: [
                Text(
                  "Prize Pool",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  width: 65,
                  height: 30,
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
              width: 25,
            ),
            Column(
              children: [
                Text(
                  "Men's Single",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  "Draw",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  width: 60,
                  height: 28,
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
              width: 25,
            ),
            Column(
              children: [
                Text(
                  "Entry Fees",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  width: 50,
                  height: 27,
                  child: Card(
                    elevation: 10,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0)),
                    color: Colors.black.withOpacity(0.25),
                    child: Text(
                      "$entryfee",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
  Widget buildAvailableSpotsCard() => Card(
        elevation: 10,
        color: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Color(0xff6EBC55),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Vacant"),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Color(0xff808080),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Booked"),
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: Color(0xffFFFF00).withOpacity(0.8),
                ),
                Text("   Processing"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(children: [
              SizedBox(
                width: 25,
                height: 30,
              ),
              Column(
                children: getTotalSpots(1, (totalspots / 2).toInt(), array1),
              ),
              SizedBox(
                width: 120,
                height: 30,
              ),
              Column(
                children: getTotalSpots(
                    (totalspots / 2).toInt() + 1, totalspots, array1),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Note :",
                style: TextStyle(color: Color(0xffD15858)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                "Matches Will be played according to the draws shown above,so please select your spot accordingly",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                "Spots Cannot be changed once selected",
                style: TextStyle(color: Color(0xffFFFFFF)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}