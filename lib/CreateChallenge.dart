import 'dart:ffi';

import 'package:ardent_sports/LiveMaintainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'EventDetails.dart';

class CreateChallenge extends StatefulWidget {
  const CreateChallenge({Key? key}) : super(key: key);

  @override
  State<CreateChallenge> createState() => _CreateChallengeState();
}

class _CreateChallengeState extends State<CreateChallenge> {
  final SportNameController = TextEditingController();
  final EventManagerNameController = TextEditingController();
  final MobileNumberController = TextEditingController();
  final EventTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Create Competition",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard() => Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white.withOpacity(0.1),
        margin: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: Colors.black.withOpacity(0.3),
              child: TextField(
                controller: SportNameController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Enter Your Sport(Badminton,TT)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                "Event Manager Detail",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Card(
                color: Colors.black.withOpacity(0.3),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: EventManagerNameController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: MobileNumberController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              color: Colors.black.withOpacity(0.3),
              child: TextField(
                controller: EventTypeController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (Fixed,Dynamic)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                "Event Type",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Card(
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "  Fixed Event: Prize Money is fixed irrespective of the number of players joining the challenge.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "  Dynamic Event:Prize money increases with increase in number of players joining the challenge.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventDetails(
                                SportName: SportNameController.text,
                                EventManagerName:
                                    EventManagerNameController.text,
                                EventManagerMobileNo:
                                    MobileNumberController.text,
                                EventType: EventTypeController.text,
                              )));
                },
                color: Colors.red,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
