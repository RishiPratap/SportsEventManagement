import 'dart:convert';
import 'dart:io';

import 'package:ardent_sports/Payment.dart';
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socket_io_client/socket_io_client.dart';

class jsonSpotNumber {
  late int spotNumber;
  late String Tournamen_id;
  jsonSpotNumber({required this.spotNumber, required this.Tournamen_id});
  Map<String, dynamic> toMap() {
    return {
      "selectedButton": this.spotNumber,
      "TOURNAMENT_ID": this.Tournamen_id
    };
  }
}

class SpotConfirmation extends StatefulWidget {
  final String SpotNo;
  final String Name;
  final String EventName;
  final String Category;
  final String Date;
  final String Address;
  final String City;
  final Socket socket;
  final String Spot_Price;
  SpotConfirmation({
    Key? key,
    required this.SpotNo,
    required this.Name,
    required this.EventName,
    required this.Category,
    required this.Date,
    required this.Address,
    required this.City,
    required this.socket,
    required this.Spot_Price,
  }) : super(key: key);

  @override
  State<SpotConfirmation> createState() => _SpotConfirmationState();
}

class _SpotConfirmationState extends State<SpotConfirmation> {
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
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: SpotConfirmationCard(),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget SpotConfirmationCard() => Card(
        elevation: 10,
        color: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 170,
              height: 38,
              child: RaisedButton(
                onPressed: () {},
                color: Color(0xff03C289),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text(
                  "Spot No : ${widget.SpotNo}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "Name : ${widget.Name}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "Event : ${widget.EventName}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "Category : ${widget.Category}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "Date: ${widget.Date}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 10, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "Address : ${widget.Address}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 10,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    width: 300,
                    height: 40,
                    child: Text(
                      "City : ${widget.City}",
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 170,
              height: 38,
              child: RaisedButton(
                onPressed: () {
                  final SpotNumber = jsonSpotNumber(
                      spotNumber: int.parse(widget.SpotNo) - 1,
                      Tournamen_id: "123456");
                  final spotNumberMap = SpotNumber.toMap();
                  final json_spotNumber = jsonEncode(spotNumberMap);
                  print("2");
                  // widget.socket.emit('confirm-booking', json_spotNumber);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: Payment(
                            Spot_Price: widget.Spot_Price,
                            Spot_Number: widget.SpotNo,
                            socket: widget.socket,
                          )));
                },
                color: Color(0xffE74745),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text(
                  "Confirm & Pay",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      );
}
