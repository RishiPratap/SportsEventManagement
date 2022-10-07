import 'package:ardent_sports/CricketMatchDetailsInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Menu.dart';

class ScoreAMatch extends StatefulWidget {
  const ScoreAMatch({Key? key}) : super(key: key);

  @override
  State<ScoreAMatch> createState() => _ScoreAMatchState();
}

class _ScoreAMatchState extends State<ScoreAMatch> {
  @override
  String sport_name = "Select a sport";
  Widget build(BuildContext context) {
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
                          'Score a match',
                          style:
                              TextStyle(color: Color(0xffE74545), fontSize: 20),
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
                      Center(
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
                      Center(
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
                      Center(
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
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: double.infinity,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE74545),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              if (sport_name == "Badminton") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Yet To be implemented"),
                                ));
                              } else if (sport_name == "Table Tennis") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Yet To be implemented"),
                                ));
                              } else if (sport_name == "Cricket") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CricketMatchDetailsInput()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Please Select a sport"),
                                ));
                              }
                            },
                            child: Text("Ok"),
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
    );
  }
}
