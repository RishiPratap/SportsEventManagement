import 'package:flutter/material.dart';
import '../../Helper/constant.dart';
import '../home_page/home_page.dart';
import 'cricket_score.dart';

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
                                    child: const Text(
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
                                    child: const Text(
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
                      const Expanded(
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
                                      child: const Text(
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD15858),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.04)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CricketScore()),
                              );
                            },
                            child: const Text("Start Scoring"),
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
      "matchid": matchid,
      "team_1": team_1,
      "team_2": team_2,
      "team_1_score": team_1_score,
      "team_2_score": team_2_score,
      "team_1_wickets": team_1_wickets,
      "team_2_wickets": team_2_wickets,
      "team_1_target": team_1_target,
      "team_2_target": team_2_target,
      "winning_team": winning_team,
      "no_of_overs": no_of_overs,
      "ball_type": ball_type,
      "city": city,
      "playing_team_size": playing_team_size,
      "toss_won_by": toss_won_by,
      "elected_to": elected_to
    };
  }
}
