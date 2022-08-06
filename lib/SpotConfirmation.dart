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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      child: SpotConfirmationCard(),
                    )
                  ],
                )),
              ),
            ),
    );
  }

  Widget SpotConfirmationCard() => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Color(0xff03C289),
            )),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                      width: 300,
                      height: 40,
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
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
                        "Event : ${mapUserResponse?['tournament_name']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
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
                        "Category : ${mapUserResponse?['cat']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
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
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
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
                        "Address : ${mapUserResponse?['address']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xff03C289),
                    )),
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
                        "City : ${mapUserResponse?['tournament_city']}",
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
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
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Text(
                  "Confirm & Pay",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
}
