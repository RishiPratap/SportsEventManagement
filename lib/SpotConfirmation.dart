import 'dart:convert';
import 'dart:io';
import 'package:ardent_sports/Payment.dart';
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String? userEmail;
  final String tournament_id;
  final String Date;
  final Socket socket;
  final String btnId;
  SpotConfirmation(
      {Key? key,
      required this.SpotNo,
      required this.userEmail,
      required this.tournament_id,
      required this.Date,
      required this.socket,
      required this.btnId})
      : super(key: key);

  @override
  State<SpotConfirmation> createState() => _SpotConfirmationState();
}

class UserDetails {
  late String name;
  late String tournamentName;
  late String tournamentCity;
  late String address;
  late String entryFee;
  late String category;

  UserDetails(
    this.name,
    this.tournamentName,
    this.tournamentCity,
    this.address,
    this.entryFee,
    this.category,
  );

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['username'];
    tournamentName = json['tournament_name'];
    tournamentCity = json['tournament_city'];
    address = json['address'];
    entryFee = json['fee'];
    category = json['cat'];
  }
}

Map? mapUserResponse;

class _SpotConfirmationState extends State<SpotConfirmation> {
  Future fetchUser() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://ardentsportsapis.herokuapp.com/getConfirmationDetails?USERID=${widget.userEmail}&TOURNAMENT_ID=${widget.tournament_id}'));

    if (response.statusCode == 200) {
      setState(() {
        mapUserResponse = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: mapUserResponse == null
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Homepage.png"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                      child: SpotConfirmationCard(deviceWidth),
                    )
                  ],
                )),
              ),
            ),
    );
  }

  Widget SpotConfirmationCard(double deviceWidth) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(deviceWidth * 0.03),
            side: BorderSide(
              color: Color(0xff03C289),
            )),
        elevation: 10,
        color: Colors.white.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceWidth * 0.06,
            ),
            Container(
              width: deviceWidth * 0.34,
              height: deviceWidth * 0.08,
              child: RaisedButton(
                onPressed: () {},
                color: Color(0xff03C289),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(deviceWidth * 0.08),
                ),
                child: Text(
                  "Spot No : ${widget.SpotNo}",
                  style: TextStyle(
                      fontSize: deviceWidth * 0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.03,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.08,
                      child: Text(
                        "Name: ${mapUserResponse?['username']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.01,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                elevation: 10,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.08,
                      child: Text(
                        "Event : ${mapUserResponse?['tournament_name']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.01,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                elevation: 10,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.08,
                      child: Text(
                        "Category : ${mapUserResponse?['cat']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.01,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.01),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                elevation: 10,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.08,
                      child: Text(
                        "Date: ${widget.Date}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.01,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                elevation: 10,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.02,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.18,
                      child: Text(
                        "Address : ${mapUserResponse?['address']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(deviceWidth * 0.03),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                elevation: 10,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.04),
                      width: deviceWidth * 0.6,
                      height: deviceWidth * 0.08,
                      child: Text(
                        "City : ${mapUserResponse?['tournament_city']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.1,
            ),
            Container(
              width: deviceWidth * 0.6,
              height: deviceWidth * 0.08,
              child: RaisedButton(
                onPressed: () {
                  final SpotNumber = jsonSpotNumber(
                      spotNumber: int.parse(widget.SpotNo) - 1,
                      Tournamen_id: widget.tournament_id);
                  final spotNumberMap = SpotNumber.toMap();
                  final json_spotNumber = jsonEncode(spotNumberMap);
                  print(widget.tournament_id);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: Payment(
                            Spot_Price: mapUserResponse?['fee'],
                            Spot_Number: widget.SpotNo,
                            socket: widget.socket,
                            btnId: widget.btnId,
                            tourneyId: widget.tournament_id,
                          )));
                },
                color: const Color(0xffE74745),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.05),
                ),
                child: Text(
                  "Confirm & Pay",
                  style: TextStyle(fontSize: deviceWidth * 0.05),
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            )
          ],
        ),
      );
}
