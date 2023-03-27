import 'package:flutter/material.dart';
import '../../Helper/constant.dart';
import '../home_page/home_page.dart';
import 'cricket_toss_details.dart';

class CricketTeamDetasilsInput extends StatefulWidget {
  final String tournamentId;
  final dynamic allMatches;
  const CricketTeamDetasilsInput({
    Key? key,
    required this.tournamentId,
    required this.allMatches,
  }) : super(key: key);

  @override
  State<CricketTeamDetasilsInput> createState() =>
      _CricketTeamDetasilsInputState();
}

class _CricketTeamDetasilsInputState extends State<CricketTeamDetasilsInput> {
  @override
  void initState() {
    super.initState();
  }

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
          style: const TextStyle(fontWeight: FontWeight.w700),
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
          backgroundColor: const Color(0xffD15858),
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
        child: const Text("Submit"),
      ),
    );
    totalPlayers.add(submit);

    return totalPlayers;
  }

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
                ],
              ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 2.5,
              margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                  deviceWidth * 0.1, deviceWidth * 0.02, deviceWidth * 0.02),
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.allMatches.map<Widget>((match) =>
                    Expanded(
            // elevation: 10,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(deviceWidth * 0.03)),
            // ,
            child: Column(
              children: [
                SizedBox(
                  height: deviceWidth * 0.08,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: deviceWidth * 0.5,
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
                          child: Text(match["TEAM_NAMES"][0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceWidth * 0.05)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: Center(
                    child: Text("Vs",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: deviceWidth * 0.8,
                    margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                        deviceWidth * 0.02, deviceWidth * 0.02, 0),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(deviceWidth * 0.02),
                        color: Colors.black.withOpacity(0.4)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(match["TEAM_NAMES"][1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: deviceWidth * 0.05)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.16,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: deviceWidth * 0.15,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD15858),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CricketTossDetails(
                                  firstTeamName: match["TEAM_NAMES"][0],
                                  secondTeamName: match["TEAM_NAMES"][1],
                                  tournamentId: widget.tournamentId,
                                  MATCH_ID : int.parse(match["MATCH_ID"])
                              )));
                    },
                    child: const Text("Next"),
                  ),
                )
              ],
            ),
          )).toList(),
              ),
              )//here,
            ],
          ),
        ),
      ),
    );
  }
}
