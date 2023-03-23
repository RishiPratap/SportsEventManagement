import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../Helper/apis.dart';
import '../../Helper/constant.dart';
import '../home_page/home_page.dart';
import 'cricket_stricker_and_non_stricker_details.dart';

class CricketTossDetails extends StatefulWidget {
  final String firstTeamName;
  final String secondTeamName;
  final String tournamentId;
  const CricketTossDetails({
    Key? key,
    required this.firstTeamName,
    required this.secondTeamName,
    required this.tournamentId,
  }) : super(key: key);

  @override
  State<CricketTossDetails> createState() => _CricketTossDetailsState();
}

class _CricketTossDetailsState extends State<CricketTossDetails> {
  @override
  void initState() {
    super.initState();
    print("😌😌" + widget.firstTeamName);
    print("😌😌" + widget.secondTeamName);
  }

  var team_name = "";
  var chose_to = "";
  var battingTeamName = "";
  var bowlingTeamName = "";
  var firstTeamPlayers = <String>[];
  var secondTeamPlayers = <String>[];
  var battingTeamPlayers = [];
  var bowlingTeamPlayers = [];
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (a, b, c) => const HomePage()));
                      },
                      child: Container(
                        width: deviceWidth * 0.18,
                        height: deviceWidth * 0.1,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/AARDENT_LOGO.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.26,
                      height: deviceWidth * 0.08,
                      decoration: const BoxDecoration(
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
              const Divider(
                color: Colors.white,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: deviceWidth * 0.08,
                      height: deviceWidth * 0.08,
                      decoration: const BoxDecoration(
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
                      decoration: const BoxDecoration(
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
                      child: const Text("Shubham"),
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
                      child: const Text("₹15,000"),
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
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "Toss Won By",
                            style: TextStyle(
                                color: Color(0xffE74545),
                                fontSize: 20,
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
                                      onPressed: () {
                                        team_name = widget.firstTeamName;
                                      },
                                      child: Text(
                                        widget.firstTeamName,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
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
                                      onPressed: () {
                                        team_name = widget.secondTeamName;
                                      },
                                      child: Text(
                                        widget.secondTeamName,
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
                      const Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "elected to",
                            style: TextStyle(
                                color: Color(0xffE74545),
                                fontSize: 20,
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
                                      onPressed: () {
                                        chose_to = "BAT";
                                        if (team_name == widget.firstTeamName) {
                                          battingTeamName =
                                              widget.firstTeamName;
                                          bowlingTeamName =
                                              widget.secondTeamName;
                                        } else if (team_name ==
                                            widget.secondTeamName) {
                                          battingTeamName =
                                              widget.secondTeamName;
                                          bowlingTeamName =
                                              widget.firstTeamName;
                                        }
                                      },
                                      child: const Text(
                                        "BAT",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
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
                                      onPressed: () {
                                        chose_to = "BALL";
                                        if (team_name == widget.firstTeamName) {
                                          battingTeamName =
                                              widget.secondTeamName;
                                          bowlingTeamName =
                                              widget.firstTeamName;
                                        } else if (team_name ==
                                            widget.secondTeamName) {
                                          battingTeamName =
                                              widget.firstTeamName;
                                          bowlingTeamName =
                                              widget.secondTeamName;
                                        }
                                      },
                                      child: const Text(
                                        "BALL",
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
                          flex: 3,
                          child: Container(
                            height: double.infinity,
                          )),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: deviceWidth * 0.15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD15858),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.04)),
                            ),
                            onPressed: () async {
                              print(
                                  "team :$team_name won the toss and chose to $chose_to. The tournament id is ${widget.tournamentId}");
                              print(
                                  "Batting team is $battingTeamName and bowling team is $bowlingTeamName");
                              // api call
                              var tossDetailsObj = {
                                "TOURNAMENT_ID": widget.tournamentId,
                                "TEAM_FORMAT": [
                                  widget.firstTeamName,
                                  widget.secondTeamName
                                ],
                                "CHOSEN_TO": chose_to,
                                "TEAM_NAME": team_name
                              };
                              var sendTossDetailsObj =
                                  jsonEncode(tossDetailsObj);
                              print(
                                  "👌 Object is : $tossDetailsObj and the json sent is $sendTossDetailsObj");
                              var url =
                                  "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/updateToss";
                              var response = await post(Uri.parse(url),
                                  body: sendTossDetailsObj,
                                  headers: {
                                    "Content-Type": "application/json"
                                  });
                              var allPlayersData = jsonDecode(response.body);
                              print("😒😒😒😒 Response : $allPlayersData");
                              // set the batting team and bowling team players

                              var teamOne = allPlayersData['one'];
                              var teamTwo = allPlayersData['two'];
                              print("PARTH EDIT HERE  ");
                              print(teamOne);
                              print(teamTwo);

                              var batTeam = [];
                              var ballTeam = [];
                              for(int i=0; i<teamOne.length; i++){
                                batTeam.add({
                                  "USERID" : teamOne[i]["USERID"],
                                  "NAME" : teamOne[i]["NAME"],
                                  "index" : i
                                });
                              }
                              for(int i=0; i<teamTwo.length; i++){
                                ballTeam.add({
                                  "USERID" : teamTwo[i]["USERID"],
                                  "NAME" : teamTwo[i]["NAME"],
                                  "index" : i
                                });
                              }

                              // for (int i = 0;
                              //     i < allPlayersData['one'].length;
                              //     i++) {
                              //   firstTeamPlayers.add((allPlayersData['one'][i]
                              //           ['NAME'])
                              //       .toString());
                              // }
                              // for (int i = 0;
                              //     i < allPlayersData['two'].length;
                              //     i++) {
                              //   secondTeamPlayers.add((allPlayersData['two'][i]
                              //           ['NAME'])
                              //       .toString());
                              // }
                              // if (battingTeamName == widget.firstTeamName) {
                              //   battingTeamPlayers = firstTeamPlayers;
                              //   bowlingTeamPlayers = secondTeamPlayers;
                              // } else if (battingTeamName ==
                              //     widget.secondTeamName) {
                              //   battingTeamPlayers = secondTeamPlayers;
                              //   bowlingTeamPlayers = firstTeamPlayers;
                              // }
                              // print(
                              //     "Battting team players are $battingTeamPlayers and bowling team players are $bowlingTeamPlayers");

                              print("New Edit Here");
                              print(battingTeamName);
                              print(bowlingTeamName);
                              print(batTeam);
                              print(ballTeam);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CricketStrickerAndNonStrickerDetails(
                                          battingTeamName: battingTeamName,
                                          bowlingTeamName: bowlingTeamName,
                                          tournamentId: widget.tournamentId,
                                          allPlayersData: allPlayersData,
                                          battingTeamPlayers:
                                              batTeam,
                                          bowlingTeamPlayers:
                                              ballTeam,
                                        )),
                              );
                            },
                            child: const Text("Next"),
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
