import 'dart:convert';
import 'package:ardent_sports/LiveMaintainerMatchSelection.dart';
import 'package:ardent_sports/SpotConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'HomePage.dart';

var update_score_1_first = 0;
var update_score_1_second = 0;
var update_score_2_first = 0;
var update_score_2_second = 0;
var update_score_3_first = 0;
var update_score_3_second = 0;

var score_1_first = 0;
var score_2_first = 0;
var score_3_first = 0;
var score_1_second = 0;
var score_2_second = 0;
var score_3_second = 0;
late Socket socket;

class player_score {
  late final int set1;
  late final int set2;
  late final int set3;
}

class Details_LiveMaintainer {
  late String entity;
  late String entity_ID;
  late String TOURNAMENT_ID;
  late String MATCHID;
  Details_LiveMaintainer({
    required this.entity,
    required this.entity_ID,
    required this.TOURNAMENT_ID,
    required this.MATCHID,
  });
  Map<String, dynamic> toMap() {
    return {
      "entity": this.entity,
      "entity_ID": this.entity_ID,
      "TOURNAMENT_ID": this.TOURNAMENT_ID,
      "MATCHID": this.MATCHID,
    };
  }
}

class Score_LiveMaintainer {
  late String PLAYER_1_SCORE;
  late String PLAYER_2_SCORE;
  late String set;
  Score_LiveMaintainer({
    required this.PLAYER_1_SCORE,
    required this.PLAYER_2_SCORE,
    required this.set,
  });
  Map<String, dynamic> toMap() {
    return {
      "PLAYER_1_SCORE": this.PLAYER_1_SCORE,
      "PLAYER_2_SCORE": this.PLAYER_2_SCORE,
      "set": this.set,
    };
  }
}

class LiveMaintainer extends StatefulWidget {
  final String Tournament_ID;
  final String Match_Id;
  final String Player_1_name;
  final String Player_2_name;
  const LiveMaintainer(
      {Key? key,
      required this.Tournament_ID,
      required this.Match_Id,
      required this.Player_1_name,
      required this.Player_2_name})
      : super(key: key);
  @override
  LiveMaintainer1 createState() => LiveMaintainer1();
}

class LiveMaintainer1 extends State<LiveMaintainer> {
  @override
  void initState() {
    super.initState();
    socket = io("http://44.202.65.121:443", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "forceNew": true,
    });
    socket.connect();
    socket.onConnect((data) => print("Connected"));

    final details = Details_LiveMaintainer(
      entity: "LIV",
      entity_ID: "shubro18@gmail.com",
      TOURNAMENT_ID: widget.Tournament_ID,
      MATCHID: widget.Match_Id,
    );
    final detailsmap = details.toMap();
    final json_details = jsonEncode(detailsmap);
    socket.emit('join-room', json_details);
    print(socket.connected);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Back Alert"),
            content: const Text("Are you sure you want to go back?"),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LiveMaintainerMatchSelection(
                                Tournament_id: widget.Tournament_ID,
                              )));
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
        body: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Homepage.png"),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.95,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.08),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.white.withOpacity(0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      "Enter Score",
                                      style: TextStyle(
                                        color: Color(0xffE74545),
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 329,
                                  height: 279,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xff252626),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 85,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 50,
                                              child: IconButton(
                                                icon: Image.asset(
                                                    'assets/edit_button.png'),
                                                onPressed: () {
                                                  print("1");
                                                  update_score_1_first =
                                                      score_1_first;
                                                  update_score_1_second =
                                                      score_1_second;
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Editbutton1(
                                                          Tournament_Id: widget
                                                              .Tournament_ID,
                                                          Match_Id:
                                                              widget.Match_Id,
                                                          Player_1_name: widget
                                                              .Player_1_name,
                                                          Player_2_name: widget
                                                              .Player_2_name,
                                                        );
                                                        ;
                                                      });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 50,
                                              child: IconButton(
                                                icon: Image.asset(
                                                    'assets/edit_button.png'),
                                                onPressed: () {
                                                  update_score_2_first =
                                                      score_2_first;
                                                  update_score_2_second =
                                                      score_2_second;
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Editbutton2(
                                                          Tournament_ID: widget
                                                              .Tournament_ID,
                                                          Match_Id:
                                                              widget.Match_Id,
                                                          Player_1_name: widget
                                                              .Player_1_name,
                                                          Player_2_name: widget
                                                              .Player_2_name,
                                                        );
                                                        ;
                                                      });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 50,
                                              child: IconButton(
                                                icon: Image.asset(
                                                    'assets/edit_button.png'),
                                                onPressed: () {
                                                  update_score_3_first =
                                                      score_3_first;
                                                  update_score_3_second =
                                                      score_3_second;
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Editbutton3(
                                                          Tournament_ID: widget
                                                              .Tournament_ID,
                                                          Match_Id:
                                                              widget.Match_Id,
                                                          Player_1_name: widget
                                                              .Player_1_name,
                                                          Player_2_name: widget
                                                              .Player_2_name,
                                                        );
                                                      });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                          width: 125,
                                          height: 240,
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 112,
                                                  height: 60,
                                                  child: Card(
                                                    elevation: 5,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    color: Color(0xff252626),
                                                    child: Center(
                                                      child: Text(
                                                          "${widget.Player_1_name}"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "$score_1_first",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "${score_2_first}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "$score_3_first",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        Container(
                                          width: 125,
                                          height: 240,
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 112,
                                                  height: 60,
                                                  child: Card(
                                                    elevation: 5,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    color: Color(0xff252626),
                                                    child: Center(
                                                      child: Text(
                                                          "${widget.Player_2_name}"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "$score_1_second",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "$score_2_second",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    "$score_3_second",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 25.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 350,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffD15858),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          if ((score_1_first > score_1_second && score_2_first > score_2_second) ||
                                              (score_1_first > score_1_second &&
                                                  score_3_first >
                                                      score_3_second) ||
                                              (score_2_first > score_2_second &&
                                                  score_3_first >
                                                      score_3_second)) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Submit(
                                                          MatchId:
                                                              widget.Match_Id,
                                                          Tournament_ID: widget
                                                              .Tournament_ID,
                                                          p1_name: widget
                                                              .Player_1_name,
                                                          p2_name: widget
                                                              .Player_2_name,
                                                        )));
                                          } else {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Submit(
                                                          MatchId:
                                                              widget.Match_Id,
                                                          Tournament_ID: widget
                                                              .Tournament_ID,
                                                          p1_name: widget
                                                              .Player_1_name,
                                                          p2_name: widget
                                                              .Player_2_name,
                                                        )));
                                          }
                                        },
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class Editbutton1 extends StatefulWidget {
  final String Tournament_Id;
  final String Match_Id;
  final String Player_1_name;
  final String Player_2_name;
  const Editbutton1(
      {Key? key,
      required this.Tournament_Id,
      required this.Match_Id,
      required this.Player_1_name,
      required this.Player_2_name})
      : super(key: key);

  @override
  State<Editbutton1> createState() => _Editbutton1State();
}

class _Editbutton1State extends State<Editbutton1> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 1 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_1_first > 0) {
                          update_score_1_first--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_1_first",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        update_score_1_first++;
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 2 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_1_second > 0) {
                          update_score_1_second--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_1_second",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        update_score_1_second++;
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      score_1_first = update_score_1_first;
                      score_1_second = update_score_1_second;
                      final Score = Score_LiveMaintainer(
                          PLAYER_1_SCORE: update_score_1_first.toString(),
                          PLAYER_2_SCORE: update_score_1_second.toString(),
                          set: "1");
                      final scoremap = Score.toMap();
                      final json_score = jsonEncode(scoremap);
                      socket.emit('update-score', json_score);
                      socket.on('score-updated', (data) {
                        print('1');
                        print(data.toString());
                      });
                      super.deactivate();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveMaintainer(
                            Tournament_ID: widget.Tournament_Id,
                            Match_Id: widget.Match_Id,
                            Player_1_name: widget.Player_1_name,
                            Player_2_name: widget.Player_2_name,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Editbutton2 extends StatefulWidget {
  final String Tournament_ID;
  final String Match_Id;
  final String Player_1_name;
  final String Player_2_name;
  const Editbutton2(
      {Key? key,
      required this.Tournament_ID,
      required this.Match_Id,
      required this.Player_1_name,
      required this.Player_2_name})
      : super(key: key);

  @override
  State<Editbutton2> createState() => _Editbutton2State();
}

class _Editbutton2State extends State<Editbutton2> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 1 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_2_first > 0) {
                          update_score_2_first--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_2_first",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        update_score_2_first++;
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 2 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_2_second > 0) {
                          update_score_2_second--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_2_second",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        setState(() {
                          update_score_2_second++;
                          super.deactivate();
                        });
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        score_2_first = update_score_2_first;
                        score_2_second = update_score_2_second;
                        super.deactivate();
                      });
                      final Score = Score_LiveMaintainer(
                          PLAYER_1_SCORE: update_score_2_first.toString(),
                          PLAYER_2_SCORE: update_score_2_second.toString(),
                          set: "2");
                      final scoremap = Score.toMap();
                      final json_score = jsonEncode(scoremap);
                      socket.emit('update-score', json_score);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveMaintainer(
                            Tournament_ID: widget.Tournament_ID,
                            Match_Id: widget.Match_Id,
                            Player_1_name: widget.Player_1_name,
                            Player_2_name: widget.Player_2_name,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}

class Editbutton3 extends StatefulWidget {
  final String Tournament_ID;
  final String Match_Id;
  final String Player_1_name;
  final String Player_2_name;
  const Editbutton3(
      {Key? key,
      required this.Tournament_ID,
      required this.Match_Id,
      required this.Player_1_name,
      required this.Player_2_name})
      : super(key: key);
  @override
  State<Editbutton3> createState() => _Editbutton3State();
}

class _Editbutton3State extends State<Editbutton3> {
  @override
  var update_score = 0;
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 1 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_3_first > 0) {
                          update_score_3_first--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_3_first",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        update_score_3_first++;
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "     Player 2 Score :",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/subtract.png'),
                    onPressed: () {
                      setState(() {
                        if (update_score_3_second > 0) {
                          update_score_3_second--;
                        }
                        super.deactivate();
                      });
                    },
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: Text(
                    " $update_score_3_second",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 50,
                  child: IconButton(
                    icon: Image.asset('assets/add.png'),
                    onPressed: () {
                      setState(() {
                        update_score_3_second++;
                        super.deactivate();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        score_3_first = update_score_3_first;
                        score_3_second = update_score_3_second;
                        final Score = Score_LiveMaintainer(
                            PLAYER_1_SCORE: update_score_3_first.toString(),
                            PLAYER_2_SCORE: update_score_3_second.toString(),
                            set: "3");
                        final scoremap = Score.toMap();
                        final json_score = jsonEncode(scoremap);
                        socket.emit('update-score', json_score);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LiveMaintainer(
                              Tournament_ID: widget.Tournament_ID,
                              Match_Id: widget.Match_Id,
                              Player_1_name: widget.Player_1_name,
                              Player_2_name: widget.Player_2_name,
                            ),
                          ),
                        ); // Timer.periodic(const Duration(seconds: 2), (timer) {});

                        super.deactivate();
                      });
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Submit extends StatefulWidget {
  final String MatchId;
  final String Tournament_ID;
  final String p1_name;
  final String p2_name;
  const Submit(
      {Key? key,
      required this.Tournament_ID,
      required this.MatchId,
      required this.p1_name,
      required this.p2_name})
      : super(key: key);

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  Map? UserResponse;
  String? x;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Back Alert"),
            content: const Text("Are you sure you want to go to back?"),
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
                  Get.to(LiveMaintainerMatchSelection(
                    Tournament_id: widget.Tournament_ID,
                  ));
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
        return false;
      },
      child: WillPopScope(
        onWillPop: () {
          Get.to(HomePage());

          return Future.value(false);
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Homepage.png"),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: Column(
                    children: [
                      Center(
                        child: Expanded(
                          child: Container(
                            height: 447,
                            width: 400,
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: Colors.white.withOpacity(0.2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        "${UserResponse == null ? "Press Confirm to know the winner" : UserResponse?['WINNER']}",
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 329,
                                    height: 279,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      color: Color(0xff252626),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 240,
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 112,
                                                    height: 60,
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      color: Color(0xff252626),
                                                      child: Center(
                                                        child: Text(
                                                            "${widget.p1_name}"),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "$score_1_first",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "${score_2_first}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "$score_3_first",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 17,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 240,
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 112,
                                                    height: 60,
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      color: Color(0xff252626),
                                                      child: Center(
                                                        child: Text(
                                                            "${widget.p2_name}"),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "$score_1_second",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "$score_2_second",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "$score_3_second",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 350,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffD15858),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0),
                                            ),
                                          ),
                                          onPressed: () async {
                                            print(widget.MatchId);
                                            print(widget.Tournament_ID);
                                            var url =
                                                "http://44.202.65.121:443/endMatch?TOURNAMENT_ID=${widget.Tournament_ID}&MATCHID=Match-${widget.MatchId}";
                                            print(url);
                                            http.Response response;
                                            response =
                                                await get(Uri.parse(url));
                                            setState(() {
                                              UserResponse =
                                                  json.decode(response.body);
                                            });
                                            print(UserResponse?['WINNER']);

                                            print(response.body);
                                          },
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Press back to exit!",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
    ;
  }
}
