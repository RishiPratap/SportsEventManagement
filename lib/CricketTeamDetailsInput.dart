import 'package:ardent_sports/CricketTossDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CricketTeamDetasilsInput extends StatefulWidget {
  final String no_of_overs;
  final String playing_team_size;
  final String Substitutes;
  final String ball_type;
  final String city;
  final String match_name;
  const CricketTeamDetasilsInput(
      {Key? key,
      required this.no_of_overs,
      required this.playing_team_size,
      required this.Substitutes,
      required this.ball_type,
      required this.city,
      required this.match_name})
      : super(key: key);

  @override
  State<CricketTeamDetasilsInput> createState() =>
      _CricketTeamDetasilsInputState();
}

class _CricketTeamDetasilsInputState extends State<CricketTeamDetasilsInput> {
  List<String> teamA_Players = [];
  List<String> teamB_Players = [];
  List<Container> buildPlayers(int count, String team_nam) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    List<Container> totalPlayers = [];
    var team_name = Container(
      margin: EdgeInsets.fromLTRB(0, deviceWidth * 0.04, 0, 0),
      child: Center(
        child: Text(
          "$team_nam Add Players",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
    totalPlayers.add(team_name);
    for (int i = 1; i <= count; i++) {
      var newPlayer = Container(
        width: MediaQuery.of(context).size.width,
        height: deviceWidth * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(deviceWidth * 0.02),
            color: Colors.black.withOpacity(0.4)),
        margin: EdgeInsets.fromLTRB(deviceWidth * 0.02, deviceWidth * 0.02,
            deviceWidth * 0.02, deviceWidth * 0.02),
        child: TextField(
          onChanged: (text) {
            if (team_name == "Team A") {
              teamA_Players.add(text);
            } else {
              teamB_Players.add(text);
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(deviceWidth * 0.02)),
            hintText: 'Player $i',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(deviceWidth * 0.02),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.001)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(deviceWidth * 0.02),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.001),
              ),
            ),
          ),
        ),
      );

      totalPlayers.add(newPlayer);
    }
    var submit = Container(
      width: MediaQuery.of(context).size.width,
      height: deviceWidth * 0.1,
      margin: EdgeInsets.fromLTRB(deviceHeight * 0.02, deviceHeight * 0.02,
          deviceWidth * 0.02, deviceWidth * 0.02),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffD15858),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(deviceWidth * 0.02)),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(teamA_Players[1]),
            ),
          );
          Navigator.pop(context, false);
        },
        child: Text("Submit"),
      ),
    );
    totalPlayers.add(submit);

    return totalPlayers;
  }

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
                    MediaQuery.of(context).size.height / 2.5,
                margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                    deviceWidth * 0.1, deviceWidth * 0.02, deviceWidth * 0.02),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.03)),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: deviceWidth * 0.08,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: deviceWidth * 0.1,
                          margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                              deviceWidth * 0.02, deviceWidth * 0.02, 0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                              color: Colors.black.withOpacity(0.4)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("    Team A Name"),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: deviceWidth * 0.09,
                                  height: deviceWidth * 0.07,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.08, 0, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              leaddialog(context, "Team A", 11,
                                                  deviceWidth));
                                    },
                                    child: Image.asset(
                                      "assets/edit_button.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Center(
                          child: Text("Vs"),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: deviceWidth * 0.1,
                          margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                              deviceWidth * 0.02, deviceWidth * 0.02, 0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                              color: Colors.black.withOpacity(0.4)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("    Team B Name"),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: deviceWidth * 0.09,
                                  height: deviceWidth * 0.07,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.08, 0, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              leaddialog(context, "Team B", 11,
                                                  deviceWidth));
                                    },
                                    child: Image.asset(
                                      "assets/edit_button.png",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth * 0.16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: deviceWidth * 0.15,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffD15858),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CricketTossDetails()));
                          },
                          child: Text("Next"),
                        ),
                      )
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

  Dialog leaddialog(BuildContext context, String team_name, int team_size,
          double deviceWidth) =>
      Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height / 6,
          child: Card(
            elevation: 10,
            color: Colors.white.withOpacity(0.2),
            child: SingleChildScrollView(
              child: Column(
                children: buildPlayers(
                    int.parse(widget.playing_team_size), team_name),
              ),
            ),
          ),
        ),
      );
}
