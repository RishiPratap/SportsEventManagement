import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

class LiveMaintainer extends StatefulWidget {
  @override
  LiveMaintainer1 createState() => LiveMaintainer1();
}

class LiveMaintainer1 extends State<LiveMaintainer> {
  // Socket socket = IO.io(
  //     'https://ardentsportsapis.herokuapp.com',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect() // disable auto-connection
  //         .build()) as Socket;

  @override
  void connect() {
    // Socket socket = io(
    //     'https://ardentsportsapis.herokuapp.com',
    //     OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .build());
    // socket.connect();
    // socket.onConnect((data) => print("Connected"));
    // print(socket.connected);
    Socket socket = io('https://ardentsportsapis.herokuapp.com');
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    print(socket.connected);
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    // Socket socket =
    //     io("https://ardentsportsapis.herokuapp.com", <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false,
    // });
    // socket.connect();
    // socket.onConnect((data) => print("Connected"));
    // print(socket.connected);
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                                                connect();
                                                update_score_1_first =
                                                    score_1_first;
                                                update_score_1_second =
                                                    score_1_second;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Editbutton1();
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return Editbutton2();
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return Editbutton3();
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
                                          color: Colors.white.withOpacity(0.2),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 112,
                                                height: 60,
                                                child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: Color(0xff252626),
                                                  child: Center(
                                                    child:
                                                        Text("Jane Prakeerth"),
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                          color: Colors.white.withOpacity(0.2),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 112,
                                                height: 60,
                                                child: Card(
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: Color(0xff252626),
                                                  child: Center(
                                                    child: Text("Riddhiman"),
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
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
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: Color(0xffD15858),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                      ),
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
    );
  }
}

class Editbutton1 extends StatefulWidget {
  const Editbutton1({Key? key}) : super(key: key);

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
                        score_1_first = update_score_1_first;
                        score_1_second = update_score_1_second;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveMaintainer()),
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
  const Editbutton2({Key? key}) : super(key: key);

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
                        });
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
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveMaintainer()),
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
    ;
  }
}

class Editbutton3 extends StatefulWidget {
  const Editbutton3({Key? key}) : super(key: key);

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
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveMaintainer()),
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
