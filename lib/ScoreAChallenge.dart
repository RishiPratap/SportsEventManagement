import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:flutter/material.dart';

import 'LiveMaintainerMatchSelection.dart';
import 'Menu.dart';

class ScoreAChallenge extends StatefulWidget {
  const ScoreAChallenge({Key? key}) : super(key: key);

  @override
  State<ScoreAChallenge> createState() => _ScoreAChallengeState();
}

class _ScoreAChallengeState extends State<ScoreAChallenge> {
  @override
  String sport_name = "Select a sport";
  TextEditingController challengeid = TextEditingController();
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 90,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/AARDENT_LOGO.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/Ardent_Sport_Text.png"),
                                fit: BoxFit.fitWidth)),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Menu()));
                        },
                        child: Container(
                          width: 20,
                          height: 16,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/menu_bar.png"),
                                  fit: BoxFit.fitHeight)),
                        ),
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
                        width: 40,
                        height: 40,
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
                        width: 40,
                        height: 40,
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
                        margin: EdgeInsets.only(left: 15),
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
                        margin: EdgeInsets.only(left: 15.0),
                        child: Text("₹15,000"),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 3,
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.white.withOpacity(0.2),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            'Score a challenge',
                            style: TextStyle(
                                color: Color(0xffE74545), fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).size.height / 1.08,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Card(
                            elevation: 10,
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                sport_name,
                                style: TextStyle(color: Color(0xffE74545)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sport_name = "Badminton";
                                    });
                                  },
                                  child: Text(
                                    "Badminton",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sport_name = "Table Tennis";
                                    });
                                  },
                                  child: Text(
                                    "Table Tennis",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sport_name = "Cricket";
                                    });
                                  },
                                  child: Text(
                                    "Cricket",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: double.infinity,
                          ),
                        ),
                        Text(
                          "Enter Challenge Id :",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            child: TextField(
                              controller: challengeid,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.04),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.04),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Enter Challenge ID :",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth * 0.1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                if (sport_name == "Badminton") {
                                  if (challengeid.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text("Please Enter the challenge ID"),
                                    ));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LiveMaintainerMatchSelection(
                                                  Tournament_id:
                                                      challengeid.text,
                                                )));
                                  }
                                } else if (sport_name == "Table Tennis") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Yet To be implemented"),
                                  ));
                                } else if (sport_name == "Cricket") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Yet To be implemented"),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Please Select a sport"),
                                  ));
                                }
                              },
                              child: Text("Ok"),
                              color: Color(0xffE74545),
                            ),
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
      ),
    );
  }
}
