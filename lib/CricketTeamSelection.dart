import 'dart:convert';
import 'package:ardent_sports/WebViewTest.dart';
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ardent_sports/Screen/Home/Home_page.dart';
import 'package:get/get.dart';

class CricketTeamDetails extends StatefulWidget {
  late dynamic data;
  late dynamic bookingDetails;
  CricketTeamDetails(
      {Key? key, required this.data, required this.bookingDetails})
      : super(key: key);

  @override
  State<CricketTeamDetails> createState() => _CricketTeamDetails();
}

Widget playerAdd(context, deviceWidth, i) => 
Container(
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
  ),
  child:
TextButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        textStyle: MaterialStateProperty.all(TextStyle(
          color: Colors.black,
        )),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ))),
    child: Text("Add player " + (i + 1).toString() + " >"),
    onPressed: () {
      addPlayer(context, i);
    })
);

Widget SubsplayerAdd(context, deviceWidth, i) => 
Container(
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
  ),
  child:
  TextButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        textStyle: MaterialStateProperty.all(TextStyle(
          color: Colors.black,
        )),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ))),
    child: Text("Substitute player " + (i + 1).toString() + " >"),
    onPressed: () {
      addPlayer(context, i);
    }),
);

void addPlayer(context, i) {
  TextEditingController addplayer = TextEditingController();
  TextEditingController addsubstitute = TextEditingController();
  TextEditingController searchplayer = TextEditingController();
  showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
            title: Text("Add Player " + (i + 1).toString()),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TextField(
                    controller: searchplayer,
                    decoration: InputDecoration(
                      labelText: 'Search Player name',
                      hintText: "Search Player name",
                      prefixIcon: Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Search"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 76, 175, 86)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )))),
                  SizedBox(height: 10),
                  TextField(
                    controller: addplayer,
                    decoration: InputDecoration(
                      labelText: 'Add Player name',
                      hintText: "Add Player name",
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: Icon(Icons.add),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 234, 16, 23)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )))),
                  SizedBox(height: 10),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Not Decided"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 175, 76, 76)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                  ),
                  SizedBox(height: 10),
                  Text("Note: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 30,
                      width: 150,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Confirm",
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 226, 64, 64)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                      ))
                ]),
              ),
            ],
          ));
}

void finalTeam(context) {
  showDialog(
      context: context,
      builder: (_) => SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
              title: const Text("Team Number"),
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Name",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Category",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Event",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Date",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Address",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("City",
                                        style: TextStyle(fontSize: 20)))),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          width: 160,
                          child: TextButton(
                              onPressed: () {},
                              child: Text("OK"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 234, 16, 23)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )))))
                    ]))
              ]));
}

void addInput(context) {
  TextEditingController addteam = TextEditingController();
  showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            contentPadding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
            title: const Text("Enter Team Name"),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  TextField(
                    controller: addteam,
                    decoration: InputDecoration(
                      labelText: 'Enter Team name',
                      hintText: "Enter Team name",
                      prefixIcon: Icon(Icons.star),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ]),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          ));
}

printdatalist(dynamic data, dynamic details) {
  data.forEach((key, value) {
    print('$key: $value');
  });

  for (var data in details) {
    data.forEach((key, value) {
      print('$key: $value');
    });
  }
}

class _CricketTeamDetails extends State<CricketTeamDetails> {
  @override
  Widget build(BuildContext context) {
    printdatalist(widget.data, widget.bookingDetails);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Homepage.png"),
                      fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Image(
                                  image: AssetImage("assets/back_edit.png"),
                                )),
                          ]),
                      Card(
                        elevation: 10,
                        color: Colors.white.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: SingleChildScrollView(
                                    child: Column(
                              children: <Widget>[
                                TextButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20)),
                                        textStyle:
                                            MaterialStateProperty.all(TextStyle(
                                          color: Colors.black,
                                        )),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                    child: Text("Add Team Name   >>"),
                                    onPressed: () {
                                      print("😀");
                                      addInput(context);
                                    }),
                                const SizedBox(height: 10),
                                for (int i = 0; i < 5; i++)
                                Padding(padding: EdgeInsets.all(10.0)
                                ,child:
                                  playerAdd(context, deviceWidth, i)),
                                SizedBox(height: 15),
                                for (int i = 0; i < 6; i++)
                                Padding(padding: EdgeInsets.all(10.0),
                                child:
                                  SubsplayerAdd(context, deviceWidth, i)),
                                SizedBox(height: 10),
                                SizedBox(
                                    height: 30,
                                    width: 150,
                                    child: TextButton(
                                      onPressed: () {
                                        finalTeam(context);
                                      },
                                      child: Text(
                                        "Submit",
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 226, 64, 64)),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ))),
                                    )),
                                SizedBox(height: 20),
                              ],
                            ))),
                          ],
                        ),
                      )
                    ])))));
  }
}
