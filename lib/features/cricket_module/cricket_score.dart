// line 1122 should fix the index out of bound error

import 'dart:convert';

import 'package:ardent_sports/features/cricket_module/MatchResult.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:ardent_sports/features/cricket_module/cricket_stricker_and_non_stricker_details.dart';

// var outURL =
//     "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/outScore";
// var outJson = {
//   "TOURNAMENT_ID":
//       widget.tournamentId,
//   "index": widget
//       .allBattingPlayers
//       .where((element) =>
//           element[
//               "NAME"] ==
//           widget.battingTeam[
//                   e as int]
//               ["NAME"])
//       .toList()[0]["index"],
//   "remarks": wickets,
// };
// print(
//     "The json is $outJson");
// var outJsonData =
//     jsonEncode(outJson);
// var outResponse =
//     await post(
//         Uri.parse(outURL),
//         headers: {
//           "Content-Type":
//               "application/json"
//         },
//         body:
//             outJsonData);
// print(
//     "The response for the out api is ${outResponse.body}");

class CricketScore extends StatefulWidget {
  final int overs;
  final int wickets;
  final bool first;
  final List<dynamic> battingTeam;
  final List<dynamic> ballingTeam;
  final dynamic striker;
  final dynamic non_striker;
  final dynamic baller;
  final String battingTeamName;
  final String bowlingTeamName;
  final String tournamentId;
  final String tossWonBy;
  final String tossWinnerChoseTo;
  final List<dynamic> allBattingPlayers;
  final List<dynamic> allBallingPlayers;
  const CricketScore({
    Key? key,
    required this.overs,
    required this.ballingTeam,
    required this.battingTeam,
    required this.first,
    required this.wickets,
    required this.striker,
    required this.non_striker,
    required this.baller,
    required this.battingTeamName,
    required this.bowlingTeamName,
    required this.tournamentId,
    required this.tossWonBy,
    required this.tossWinnerChoseTo,
    required this.allBattingPlayers,
    required this.allBallingPlayers,
  }) : super(key: key);

  get btnVal => "0";
  @override
  State<CricketScore> createState() => _CricketScoreState();
}

String strikerName = "";
String nonStrikerName = "";
bool _currentStriker = true;
bool _currentNonStriker = false;
var _currentOver = "";
var _currentMatchScore = 0;
var _currentStrikerScore = 0;
var _currentWickets = 0;
var _currentNonStrikerScore = 0;
var _currentStrickerBallcount = 0;
var _currentNonStrickerBallcount = 0;
double _currentBalleOver = 0.0;
int _currentBowlingCount = 0;
int _currentbowlingExtra = 0;
bool allowLastmanPostion = true;
List<String> bowlerList = [];
bool matchInning = false;
int matchInningCount = 0;
bool matchComplete = false;
bool setButtonDisable = false;
var scoringData;
List<String> WicketsType = [
  'LBW',
  'Bowled',
  'Catch Out',
  'Stricker Run Out',
  'Non-Stricker Run Out',
  'Stumped',
  'Hit Wicket'
];
var ways = {
  "LBW": "LBW",
  "Bowled": "B",
  "Catch Out": "C",
  "Stricker Run Out": "RO",
  "Non-Stricker Run Out": "RO",
  "Stumped": "ST",
  "Hit Wicket": "HW",
};
var curr_bowler_name;

class _CricketScoreState extends State<CricketScore> {
  var finalBattingTeam;
  var finalBallingTeam;
  var nowStriker;
  var nowNonStriker;
  var nowBaller;
  @override
  void initState() {
    super.initState();
    List<String> b = [];
    for (int i = 0; i < widget.ballingTeam.length; i++) {
      b.add(widget.ballingTeam[i]["NAME"]);
    }
    setState(() {
      bowlerList = b;
      curr_bowler_name = widget.baller["NAME"];
      strikerName = widget.striker["NAME"];
      nonStrikerName = widget.non_striker["NAME"];
      finalBattingTeam = widget.battingTeam;
      finalBallingTeam = widget.ballingTeam;
      nowStriker = widget.striker;
      nowNonStriker = widget.non_striker;
      nowBaller = widget.baller;
      matchInning = false;
      setButtonDisable = false;
    });
    _clear();
  }

  void scoringkeyFunc(int score) async {
    var url =
        "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/usualScore";
    var sendData = {
      "TOURNAMENT_ID": widget.tournamentId,
      "score": score.toString(),
    };
    var jsonData = jsonEncode(sendData);
    var response = await post(Uri.parse(url),
        body: jsonData, headers: {"Content-Type": "application/json"});
    String datalist = jsonDecode(response.body);
    print({"😁😁response is : ", datalist.toString()});
    setState(() {
      scoringData = jsonDecode(response.body);
    });
  }

  void bowler() async {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if ((_currentBalleOver).toInt() == widget.overs) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) =>
            SimpleDialog(title: const Text('Match Over !'), children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Innings Over! Change Innings")),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    setButtonDisable = true;
                  });
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ]),
      );
      setState(() {
        // redirect to "NeXT INNINGS"
        print("An innings got over");
        matchInning = true;
        matchInningCount++;
        print({"🌐", matchInningCount});
      });
    }
    if (_currentBowlingCount == 6) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Choose Bowler"),
                content: Container(
                  height: h * 0.3,
                  width: w * 0.3,
                  child: ListView.builder(
                    itemCount: bowlerList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(bowlerList[index]),
                        onTap: () async {
                          setState(() {
                            curr_bowler_name = bowlerList[index];
                          });
                          // make api call to change over
                          var url =
                              "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/changeOverCricket";
                          var Overjson = {
                            "TOURNAMENT_ID": widget.tournamentId,
                            "baller_index": widget.allBallingPlayers
                                .where((element) =>
                                    element["NAME"] == bowlerList[index])
                                .toList()[0]["index"],
                          };
                          var jsonData = jsonEncode(Overjson);
                          print("The json data is: " + Overjson.toString());
                          var response = await post(Uri.parse(url),
                              body: jsonData,
                              headers: {"Content-Type": "application/json"});
                          print("😁😁response For over change is : " +
                              response.body);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ));
      setState(() {
        _currentNonStriker = !_currentNonStriker;
        _currentStriker = !_currentStriker;
        _currentOver = "";
        double temp = _currentBalleOver;
        _currentBalleOver = temp + 1.0 - 0.6;
        _currentBowlingCount = 0;
      });
    }
    // if (matchComplete) {
    //   setState(() {
    //     if (matchComplete) {
    //       showDialog(
    //           barrierDismissible: false,
    //           context: context,
    //           builder: (_) => SimpleDialog(
    //                 title: const Text("Match Complete"),
    //                 children: [
    //                   const Padding(
    //                       padding: EdgeInsets.all(10.0),
    //                       child: Text("Match Complete")),
    //                   Padding(
    //                       padding: EdgeInsets.all(10.0),
    //                       child: ElevatedButton(
    //                           onPressed: () {
    //                             Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                     builder: (context) => MatchResult()));
    //                           },
    //                           child: const Text("OK")))
    //                 ],
    //               ));
    //     }
    //   });
    // }
  }

  void scoreRun(int run) {}

  final TextEditingController _searchInputControllor = TextEditingController();

  void appendCharacters() {
    String oldText = _searchInputControllor.text;
    String newText = oldText + widget.btnVal;

    var newValue = _searchInputControllor.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
      composing: TextRange.empty,
    );

    _searchInputControllor.value = newValue;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: SizedBox(
        height: h,
        child: Stack(
          children: [
            Positioned(
              top: h * 0.03,
              left: w * 0.01,
              child: TextButton(
                child: Text(
                  "<",
                  style: TextStyle(
                      fontSize: w * 0.09,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            _header(),
            // _score(),
            Positioned(
              top: h * 0.23,
              left: w * 0.65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent),
                onPressed: () async {
                  if (matchInning) {
                    // call change innings api
                    var url =
                        "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/changeInningCricket";
                    var inningsJson = {
                      "TOURNAMENT_ID": widget.tournamentId,
                    };
                    var inningsJsonData = jsonEncode(inningsJson);
                    print("The json data is: " + inningsJson.toString());
                    var response = await post(Uri.parse(url),
                        body: inningsJsonData,
                        headers: {"Content-Type": "application/json"});
                    print("😌😌 response from innings change api is: " +
                        response.body);
                    // Redirect to next innings page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CricketStrickerAndNonStrickerDetails(
                                  tournamentId: widget.tournamentId,
                                  battingTeamName: widget.bowlingTeamName,
                                  bowlingTeamName: widget.battingTeamName,
                                  overs: widget.overs,
                                  wickets: widget.wickets,
                                  first: !(widget.first),
                                  tossWonBy: widget.tossWonBy,
                                  tossWinnerChoseTo: widget.tossWinnerChoseTo,
                                  battingTeamPlayers: widget.allBallingPlayers,
                                  bowlingTeamPlayers: widget.allBattingPlayers,
                                )));
                  } else {}
                  ;
                },
                child: (matchInning)
                    ? const Text(
                        "Change Innings",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )
                    : const Text(""),
              ),
            ),
            _batsmanScore(),
            _score(), //TODO ADD SCORING PART
            Positioned(
              top: h * 0.42,
              left: w * 0.11,
              child: Text(
                "${widget.tossWonBy} won the toss and elected to ${widget.tossWinnerChoseTo} first",
                style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            // _score(),
            _scoreCard(),
            _bowlerCard(),
            _keyBoard(),
            _keyBoard2(),
            _keyBoard3(),
            _submit(),
          ],
        ),
      )),
    );
  }

  void _clear() {
    setState(() {
      _currentOver = "";
      _currentMatchScore = 0;
      _currentStrikerScore = 0;
      _currentNonStrikerScore = 0;
      _currentStrickerBallcount = 0;
      _currentNonStrickerBallcount = 0;
      _currentStriker = true;
      _currentNonStriker = false;
      _currentBalleOver = 0.0;
      _currentWickets = 0;
      _currentBowlingCount = 0;
      matchInning = false;
    });
  }

  _header() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0.08,
      right: 0.08,
      top: h * 0.1,
      child: Container(
          height: h * 0.12,
          decoration: new BoxDecoration(color: Color.fromARGB(154, 95, 96, 95)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.all(w * 0.02),
              child: Text(
                widget.battingTeamName,
                style: TextStyle(
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(w * 0.01),
              child: TextButton(
                onPressed: () {
                  print("Pressed");
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.red,
                  size: w * 0.03,
                ),
              ),
            ),
          ])),
    );
  }

  _score() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.3,
      left: w * 0.65,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: w * 0.02),
            child: Padding(
              padding: EdgeInsets.all(w * 0.02),
              child: Text(
                  "(${(_currentBalleOver).toStringAsFixed(1)})/${widget.overs}",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  _batsmanScore() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.27,
      left: w * 0.3,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: w * 0.02),
            child: Padding(
              padding: EdgeInsets.all(w * 0.02),
              child: Text("(${_currentMatchScore}/${_currentWickets})",
                  style: TextStyle(
                      fontSize: w * 0.1,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  _scoreCard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.48,
      left: h * 0.02,
      right: w * 0.04,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Center(
                child: Column(children: <Widget>[
              SizedBox(height: h * 0.01),
              Row(children: [Text(strikerName)]),
              SizedBox(height: h * 0.01),
              Row(children: [
                Text(
                  "${_currentStrikerScore}",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "(${_currentStrickerBallcount})",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(height: h * 0.01),
              ]),
            ])),
            SizedBox(width: w * 0.02),
            (_currentStriker)
                ? Image(
                    width: w * 0.07,
                    height: h * 0.07,
                    image: const NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/8258/8258931.png'),
                  )
                : Container(),
          ]),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 60),
              maximumSize: const Size(150, 60),
              elevation: 5,
              backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () async{
            var url = "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/changeStrike";
            var sendJSON = jsonEncode({"TOURNAMENT_ID" : widget.tournamentId});

            var resp =
            await post(Uri.parse(url),
                headers: {
                  "Content-Type":
                  "application/json"
                },
                body:
                sendJSON);
            print(resp.body);
            setState(() {
              _currentNonStriker = !_currentNonStriker;
              _currentStriker = !_currentStriker;
            });
          },
        ),
        ElevatedButton(
          child: Row(children: [
            Center(
                child: Column(children: <Widget>[
              SizedBox(height: h * 0.01),
              Row(children: [Text(nonStrikerName)]),
              SizedBox(height: h * 0.01),
              Row(children: [
                Text(
                  "${_currentNonStrikerScore}",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "(${_currentNonStrickerBallcount})",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(height: h * 0.01),
              ]),
            ])),
            SizedBox(width: w * 0.02),
            (_currentNonStriker)
                ? Image(
                    width: w * 0.07,
                    height: h * 0.07,
                    image: const NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/8258/8258931.png'),
                  )
                : Container()
          ]),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 60),
              maximumSize: const Size(150, 60),
              elevation: 5,
              backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () async{
            var url = "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/changeStrike";
            var sendJSON = jsonEncode({"TOURNAMENT_ID" : widget.tournamentId});

            var resp =
                await post(Uri.parse(url),
                headers: {
                  "Content-Type":
                  "application/json"
                },
                body:
                sendJSON);
            print(resp.body);
            setState(() {
              _currentNonStriker = !_currentNonStriker;
              _currentStriker = !_currentStriker;
            });
          },
        ),
      ]),
    );
  }

  _bowlerCard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.56,
      left: h * 0.02,
      right: w * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                width: w * 0.1,
                height: h * 0.1,
                image: const NetworkImage(
                    'https://cdn.iconscout.com/icon/premium/png-256-thumb/cricket-ball-2574544-2171281.png'),
              ),
              InkWell(
                  onTap: () {},
                  //parth
                  child: Text(
                    curr_bowler_name,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _currentOver,
                    style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.5),
                  )))
        ],
      ),
    );
  }

  _keyBoard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.65,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            width: w * 0.2,
            height: w * 0.15,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
                child: const Text("0"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    backgroundColor: Colors.red),
                onPressed: () {
                  setButtonDisable
                      ? null
                      : setState(() {
                          _currentOver += "0-";
                          _currentMatchScore += 0;
                          _currentBalleOver += 0.1;
                          _currentBowlingCount += 1;
                          scoringkeyFunc(0);
                        });
                  if (_currentStriker) {
                    setState(() {
                      _currentStrikerScore += 0;
                      _currentStrickerBallcount += 1;
                    });
                  } else {
                    setState(() {
                      _currentNonStrikerScore += 0;
                      _currentNonStrickerBallcount += 1;
                    });
                  }
                  //#TODO: Change the striker and non striker
                  var ballsCount = _currentOver.length;
                  print(_currentBowlingCount);
                  bowler();
                })),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("1"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "1-";
                        _currentMatchScore += 1;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        print(_currentOver.length);
                        scoringkeyFunc(1);
                      });
                if (_currentStriker) {
                  setState(() {
                    _currentStrikerScore += 1;
                    _currentStrickerBallcount += 1;
                  });
                } else {
                  setState(() {
                    _currentNonStrikerScore += 1;
                    _currentNonStrickerBallcount += 1;
                  });
                }
                //#TODO: Change the striker and non striker
                var ballsCount = _currentOver.length;
                print(_currentBowlingCount);
                bowler();
                setState(() {
                  _currentStriker = !_currentStriker;
                  _currentNonStriker = !_currentNonStriker;
                });
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("2"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "2-";
                        _currentMatchScore += 2;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        scoringkeyFunc(2);
                      });
                if (_currentStriker) {
                  setState(() {
                    _currentStrikerScore += 2;
                    _currentStrickerBallcount += 1;
                  });
                } else {
                  setState(() {
                    _currentNonStrikerScore += 2;
                    _currentNonStrickerBallcount += 1;
                  });
                }
                //#TODO: Change the striker and non striker
                var ballsCount = _currentOver.length;
                print(_currentBowlingCount);
                bowler();
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("Undo"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable ? null : print(_currentOver.length);
                if (_currentOver.length == 0) {
                  Fluttertoast.showToast(
                      msg: "No ball to undo",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 11, 11, 11),
                      textColor: Color.fromARGB(255, 33, 237, 6),
                      fontSize: 16.0);
                } else {
                  setState(() {
                    _currentOver =
                        _currentOver.substring(0, _currentOver.length - 1);
                  });
                }
              },
            )),
      ]),
    );
  }

  _keyBoard2() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    int ballsCount;
    return Positioned(
      top: h * 0.74,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("3"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  backgroundColor: Colors.red),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "3-";
                        _currentMatchScore += 3;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        scoringkeyFunc(3);
                      });
                if (_currentStriker) {
                  setState(() {
                    _currentStrikerScore += 3;
                    _currentStrickerBallcount += 1;
                  });
                } else {
                  setState(() {
                    _currentNonStrikerScore += 3;
                    _currentNonStrickerBallcount += 1;
                  });
                }
                //#TODO: Change the striker and non striker
                var ballsCount = _currentOver.length;
                print(_currentBowlingCount);
                bowler();
                setState(() {
                  _currentNonStriker = !_currentNonStriker;
                  _currentStriker = !_currentStriker;
                });
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("4"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "4-";
                        _currentMatchScore += 4;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        scoringkeyFunc(4);
                      });
                if (_currentStriker) {
                  setState(() {
                    _currentStrikerScore += 4;
                    _currentStrickerBallcount += 1;
                  });
                } else {
                  setState(() {
                    _currentNonStrikerScore += 4;
                    _currentNonStrickerBallcount += 1;
                  });
                }
                //#TODO: Change the striker and non striker
                var ballsCount = _currentOver.length;
                print(_currentBowlingCount);
                bowler();
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("6"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "6-";
                        _currentMatchScore += 6;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        scoringkeyFunc(6);
                      });
                if (_currentStriker) {
                  setState(() {
                    _currentStrikerScore += 6;
                    _currentStrickerBallcount += 1;
                  });
                } else {
                  setState(() {
                    _currentNonStrikerScore += 6;
                    _currentNonStrickerBallcount += 1;
                  });
                }
                //#TODO: Change the striker and non striker
                var ballsCount = _currentOver.length;
                print(_currentBowlingCount);
                bowler();
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("5"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () => {
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "5-";
                        _currentMatchScore += 5;
                        _currentBalleOver += 0.1;
                        _currentBowlingCount += 1;
                        scoringkeyFunc(5);
                      }),
                if (_currentStriker)
                  {
                    setState(() {
                      _currentStrikerScore += 5;
                      _currentStrickerBallcount += 1;
                    })
                  }
                else
                  {
                    setState(() {
                      _currentNonStrikerScore += 5;
                      _currentNonStrickerBallcount += 1;
                    })
                  },
                ballsCount = _currentOver.length,
                print(_currentBowlingCount),
                bowler(),
                setState(() {
                  _currentStriker = !_currentStriker;
                  _currentNonStriker = !_currentNonStriker;
                }),
              },
            )),
      ]),
    );
  }

  _keyBoard3() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    TextEditingController nbscore = TextEditingController();
    return Positioned(
      top: h * 0.83,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("WD"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  backgroundColor: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                      title: const Text('Score'),
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Column(children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: nbscore,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(onPressed: () async{
                                print(nbscore.text);
                                var url = "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/specialRuns";
                                var sendData = jsonEncode({
                                  "TOURNAMENT_ID" : widget.tournamentId,
                                  "score" : int.parse(nbscore.text),
                                  "remarks" : "Wide Ball"
                                });
                                var resp =
                                await post(Uri.parse(url),
                                    headers: {
                                      "Content-Type":
                                      "application/json"
                                    },
                                    body:
                                    sendData);
                                print(resp.body);
                                Navigator.pop(context);
                              }, child: const Text("Ok"))
                            ]))
                      ]),
                );
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "WD-";
                        _currentMatchScore += 1;
                        _currentMatchScore += int.parse(nbscore.text);
                        if(_currentStriker){
                          _currentStrikerScore = int.parse(nbscore.text);
                        } else{
                          _currentNonStrikerScore = int.parse(nbscore.text);
                        }
                        if(int.parse(nbscore.text) % 2 == 1){
                          _currentNonStriker = !_currentNonStriker;
                          _currentStriker = !_currentStriker;
                        }
                      });
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("NB"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                      title: const Text('Score'),
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Column(children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                  controller: nbscore,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(onPressed: () async{
                                print(nbscore.text);
                                var url = "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/specialRuns";
                                var sendData = jsonEncode({
                                  "TOURNAMENT_ID" : widget.tournamentId,
                                  "score" : int.parse(nbscore.text),
                                  "remarks" : "No Ball"
                                });
                                var resp =
                                await post(Uri.parse(url),
                                headers: {
                                  "Content-Type":
                                    "application/json"
                                },
                                body:
                                sendData);
                                print(resp.body);
                                Navigator.pop(context);
                              }, child: const Text("Ok"))
                            ]))
                      ]),
                );

                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "NB-";
                        _currentMatchScore += 1;
                        _currentMatchScore += int.parse(nbscore.text);

                        if(_currentStriker){
                          _currentStrikerScore = int.parse(nbscore.text);
                        } else{
                          _currentNonStrikerScore = int.parse(nbscore.text);
                        }

                        if(int.parse(nbscore.text) % 2 == 1){
                          _currentNonStriker = !_currentNonStriker;
                          _currentStriker = !_currentStriker;
                        }
                      });
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text("BYE"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                      title: const Text('Score'),
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Column(children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: nbscore,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(onPressed: () async{
                                print(nbscore.text);
                                var url = "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/specialRuns";
                                var sendData = jsonEncode({
                                  "TOURNAMENT_ID" : widget.tournamentId,
                                  "score" : int.parse(nbscore.text),
                                  "remarks" : "Bye Ball"
                                });
                                var resp =
                                await post(Uri.parse(url),
                                    headers: {
                                      "Content-Type":
                                      "application/json"
                                    },
                                    body:
                                    sendData);
                                print(resp.body);
                                Navigator.pop(context);
                              }, child: const Text("Ok"))
                            ]))
                      ]),
                );
                setButtonDisable
                    ? null
                    : setState(() {
                        _currentOver += "Bye-";
                        _currentMatchScore += int.parse(nbscore.text);

                        if(_currentStriker){
                          _currentStrikerScore = int.parse(nbscore.text);
                        } else{
                          _currentNonStrikerScore = int.parse(nbscore.text);
                        }

                        if(int.parse(nbscore.text) % 2 == 1){
                          _currentNonStriker = !_currentNonStriker;
                          _currentStriker = !_currentStriker;
                        }
                      });
              },
            )),
        SizedBox(
            width: w * 0.2,
            height: w * 0.15,
            child: ElevatedButton(
              child: const Text(
                "Out",
                style: TextStyle(color: Colors.red),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                setButtonDisable
                    ? null
                    : setState(() {
                        showDialog(
                          context: context,
                          builder: (_) => SimpleDialog(
                            title: const Text('Wicket Type'),
                            children: <Widget>[
                              for (String wickets in WicketsType)
                                SimpleDialogOption(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => SimpleDialog(
                                          title: const Text('New Player'),
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  DropdownButtonFormField(
                                                    hint: Text((wickets ==
                                                            "Non-Stricker Run Out")
                                                        ? "Next Non-Striker"
                                                        : "Next Striker"),
                                                    items: widget.battingTeam
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  e["NAME"]),
                                                              value: e["index"],
                                                            ))
                                                        .toList(),
                                                    onChanged: (e) async {
                                                      print("The value is $e");

                                                      // call api
                                                      // var outURL =
                                                      //     "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/outScore";
                                                      // var outJson = {
                                                      //   "TOURNAMENT_ID":
                                                      //       widget.tournamentId,
                                                      //   "index": widget
                                                      //       .allBattingPlayers
                                                      //       .where((element) =>
                                                      //           element[
                                                      //               "NAME"] ==
                                                      //           widget.battingTeam[
                                                      //                   e as int]
                                                      //               ["NAME"])
                                                      //       .toList()[0]["index"],
                                                      //   "remarks": wickets,
                                                      // };
                                                      // print(
                                                      //     "The json is $outJson");
                                                      // var outJsonData =
                                                      //     jsonEncode(outJson);
                                                      // var outResponse =
                                                      //     await post(
                                                      //         Uri.parse(outURL),
                                                      //         headers: {
                                                      //           "Content-Type":
                                                      //               "application/json"
                                                      //         },
                                                      //         body:
                                                      //             outJsonData);
                                                      // print(
                                                      //     "The response for the out api is ${outResponse.body}");
                                                      setState(() {
                                                        if (wickets !=
                                                            "Non-Stricker Run Out") {
                                                          if (_currentStriker) {
                                                            strikerName = widget
                                                                    .allBattingPlayers[
                                                                e as int]["NAME"];
                                                            // reset the striker score and ball count
                                                            _currentStrikerScore =
                                                                0;
                                                            _currentStrickerBallcount =
                                                                0;
                                                          } else {
                                                            nonStrikerName =
                                                                widget.allBattingPlayers[
                                                                        e as int]
                                                                    ["NAME"];
                                                            // reset the non striker score and ball count
                                                            _currentNonStrikerScore =
                                                                0;
                                                            _currentNonStrickerBallcount =
                                                                0;
                                                          }
                                                        } else {
                                                          if (_currentStriker) {
                                                            nonStrikerName =
                                                                widget.allBattingPlayers[
                                                                        e as int]
                                                                    ["NAME"];
                                                            // reset the non striker score and ball count
                                                            _currentNonStrikerScore =
                                                                0;
                                                            _currentNonStrickerBallcount =
                                                                0;
                                                          } else {
                                                            strikerName = widget
                                                                    .allBattingPlayers[
                                                                e as int]["NAME"];
                                                            // reset the striker score and ball count
                                                            _currentStrikerScore =
                                                                0;
                                                            _currentStrickerBallcount =
                                                                0;
                                                          }
                                                        }
                                                        _currentOver +=
                                                            ("${ways[wickets]}  -");
                                                        _currentWickets += 1;
                                                        _currentBowlingCount +=
                                                            1;
                                                        _currentBalleOver +=
                                                            0.1;
                                                        bowler();
                                                      });
                                                      // call api here only..
                                                      var outURL =
                                                          "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/outScore";
                                                      var outJson = {
                                                        "TOURNAMENT_ID":
                                                            widget.tournamentId,
                                                        "index": widget
                                                            .allBattingPlayers
                                                            .where((element) =>
                                                                element[
                                                                    "NAME"] ==
                                                                widget.battingTeam[
                                                                        e as int]
                                                                    ["NAME"])
                                                            .toList()[0]["index"],
                                                        "remarks": wickets,
                                                      };
                                                      print(
                                                          "The json is $outJson");
                                                      var outJsonData =
                                                          jsonEncode(outJson);
                                                      var outResponse =
                                                          await post(
                                                              Uri.parse(outURL),
                                                              headers: {
                                                                "Content-Type":
                                                                    "application/json"
                                                              },
                                                              body:
                                                                  outJsonData);
                                                      print(
                                                          "The response for the out api is ${outResponse.body}");
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ]))
                                          ]),
                                    );
                                  },
                                  child: Text(wickets),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Done",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 54, 181, 244)),
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
                //rishi
                //end match
                if (_currentWickets == widget.wickets) {
                  showDialog(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: const Text('All Out Confirm'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            setState(() {
                              matchInning = true;
                              matchInningCount += 1;
                              setButtonDisable = true;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Declare All Out'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            setState(() {
                              _currentNonStriker = _currentStriker;
                            });
                            bowler();
                            Navigator.pop(context);
                          },
                          child: const Text('Allow Last Man to Bat'),
                        ),
                      ],
                    ),
                  );
                }
                if (_currentStriker) {
                  _currentStrikerScore += 0;
                  _currentStrickerBallcount += 1;
                } else {
                  _currentNonStrikerScore += 0;
                  _currentNonStrickerBallcount += 1;
                }
                bowler();
              },
            )),
      ]),
    );
  }

  _submit() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Positioned(
        top: h * 0.92,
        left: w * 0.2,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: const Color(0xFFD15858),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
                )),
            onPressed: () {
              setState(() {
                _currentOver = "";
                _currentMatchScore = 0;
                _currentStrikerScore = 0;
                _currentNonStrikerScore = 0;
                _currentStrickerBallcount = 0;
                _currentNonStrickerBallcount = 0;
                _currentStriker = true;
                _currentNonStriker = false;
                _currentBalleOver = 0.0;
                _currentWickets = 0;
                _currentBowlingCount = 0;
                matchInningCount = 0;
              });
            },
            child: SizedBox(
                width: w * 0.442,
                height: w * 0.14,
                child: Padding(
                  padding: EdgeInsets.all(w * 0.03),
                  child: Text(
                    "Clear",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                    ),
                  ),
                )),
          ),
        ));
  }
}

//!CR179543-CR-NA
