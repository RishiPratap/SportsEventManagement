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
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
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
                height: deviceWidth * 0.2,
              ),
              Text(
                "Create Competition",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: deviceWidth * 0.05,
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              buildCard(deviceWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(double deviceWidth) => Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.01),
        ),
        color: Colors.white.withOpacity(0.1),
        margin: EdgeInsets.only(
            left: deviceWidth * 0.05, right: deviceWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceWidth * 0.04,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
              color: Colors.black.withOpacity(0.3),
              child: TextField(
                controller: SportNameController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Enter Your Sport(Badminton,TT)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.06),
                    )),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
              child: Text(
                "Event Manager Detail",
                style: TextStyle(
                  fontSize: deviceWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
              child: Card(
                color: Colors.black.withOpacity(0.3),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04)),
                      child: TextField(
                        controller: EventManagerNameController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04)),
                      child: TextField(
                        controller: MobileNumberController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 10, deviceWidth * 0.03, 0),
              color: Colors.black.withOpacity(0.3),
              child: TextField(
                controller: EventTypeController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Event Type (Fixed,Dynamic)",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 10, deviceWidth * 0.03, 0),
              child: Text(
                "Event Type",
                style: TextStyle(
                    fontSize: deviceWidth * 0.05, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
              child: Card(
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceWidth * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                      child: Text(
                        "Fixed Event: Prize Money is fixed irrespective of the number of players joining the challenge.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                      child: Text(
                        "Dynamic Event:Prize money increases with increase in number of players joining the challenge.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: deviceWidth * 0.8,
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
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
                    borderRadius: BorderRadius.circular(deviceWidth * 0.06)),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
          ],
        ),
      );
}
