import 'dart:convert';

import 'package:ardent_sports/CricketScore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CricketStrickerAndNonStrickerDetails extends StatefulWidget {
  const CricketStrickerAndNonStrickerDetails({Key? key}) : super(key: key);

  @override
  State<CricketStrickerAndNonStrickerDetails> createState() =>
      _CricketStrickerAndNonStrickerDetailsState();
}

class _CricketStrickerAndNonStrickerDetailsState
    extends State<CricketStrickerAndNonStrickerDetails> {
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
                image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.18,
                      height: deviceWidth * 0.1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/AARDENT_LOGO.png"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.26,
                      height: deviceWidth * 0.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Ardent_Sport_Text.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.08,
                      height: deviceWidth * 0.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Profile_Image.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.08,
                      height: deviceWidth * 0.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/money_bag.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: deviceWidth * 0.03),
                      child: Text("Shubham"),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: deviceWidth * 0.03),
                      child: Text("₹15,000"),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.all(deviceWidth * 0.02),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.03)),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "Team A",
                            style: TextStyle(
                                color: Color(0xffE74545),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Select Striker",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Select Non Striker",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "Team B",
                            style: TextStyle(
                                color: Color(0xffE74545),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Select Bowler",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            height: double.infinity,
                          )),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffD15858),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.04)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CricketScore()),
                              );
                            },
                            // onPressed: () async {
                            //   final match_details = match_Details(
                            //       matchid: "12359",
                            //       team_1: ["Doraemon"],
                            //       team_2: ["Doraemon"],
                            //       team_1_score: 0,
                            //       team_2_score: 0,
                            //       team_1_wickets: 0,
                            //       team_2_wickets: 0,
                            //       team_1_target: 10,
                            //       team_2_target: 10,
                            //       winning_team: "He",
                            //       no_of_overs: 5,
                            //       ball_type: "H",
                            //       city: "Nzb",
                            //       playing_team_size: 5,
                            //       toss_won_by: "a",
                            //       elected_to: "baT");
                            //   final match_details_map = match_details.toMap();
                            //   final json = jsonEncode(match_details_map);
                            //   var url =
                            //       "https://ardentsportsapis.herokuapp.com/cricketMatchDetails";
                            //   var response = await post(Uri.parse(url),
                            //       headers: {
                            //         "Accept": "application/json",
                            //         "Content-Type": "application/json"
                            //       },
                            //       body: json,
                            //       encoding: Encoding.getByName("utf-8"));
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(SnackBar(
                            //     content: Text(response.statusCode.toString()),
                            //   ));
                            // },
                            child: Text("Start Scoring"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class match_Details {
  late String matchid;
  late List<String> team_1;
  late List<String> team_2;
  late int team_1_score;
  late int team_2_score;
  late int team_1_wickets;
  late int team_2_wickets;
  late int team_1_target;
  late int team_2_target;
  late String winning_team;
  late int no_of_overs;
  late String ball_type;
  late String city;
  late int playing_team_size;
  late String toss_won_by;
  late String elected_to;
  match_Details(
      {required this.matchid,
      required this.team_1,
      required this.team_2,
      required this.team_1_score,
      required this.team_2_score,
      required this.team_1_wickets,
      required this.team_2_wickets,
      required this.team_1_target,
      required this.team_2_target,
      required this.winning_team,
      required this.no_of_overs,
      required this.ball_type,
      required this.city,
      required this.playing_team_size,
      required this.toss_won_by,
      required this.elected_to});
  Map<String, dynamic> toMap() {
    return {
      "matchid": this.matchid,
      "team_1": this.team_1,
      "team_2": this.team_2,
      "team_1_score": this.team_1_score,
      "team_2_score": this.team_2_score,
      "team_1_wickets": this.team_1_wickets,
      "team_2_wickets": this.team_2_wickets,
      "team_1_target": this.team_1_target,
      "team_2_target": this.team_2_target,
      "winning_team": this.winning_team,
      "no_of_overs": this.no_of_overs,
      "ball_type": this.ball_type,
      "city": this.city,
      "playing_team_size": this.playing_team_size,
      "toss_won_by": this.toss_won_by,
      "elected_to": this.elected_to
    };
  }
}
