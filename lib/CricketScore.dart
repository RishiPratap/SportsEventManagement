import 'package:flutter/material.dart';

class CricketScore extends StatefulWidget {
  const CricketScore({Key? key}) : super(key: key);

  @override
  State<CricketScore> createState() => _CricketScoreState();
}

class _CricketScoreState extends State<CricketScore> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: h,
          child: Stack(
            children: [
              Positioned(
                top: h * 0.08,
                left: w * 0.1,
                child: Text("<",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              _header(),
              Positioned(
                top: h * 0.21,
                left: w * 0.56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  onPressed: () {
                    print("Match Result pressed");
                  },
                  child: Text(
                    "Match Results >",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              _score(),
              Positioned(
                top: h * 0.4,
                left: w * 0.11,
                child: Text(
                  "Team A won the toss and elected to bat first",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0.08,
      right: 0.08,
      top: h * 0.15,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Team A",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextButton(
            onPressed: () {
              print("Pressed");
            },
            child: Icon(
              Icons.settings,
              color: Colors.red,
              size: 24,
            ),
          ),
        ),
      ]),
    );
  }

  _score() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.3,
      left: w * 0.4,
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text("0/0",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: h * 0.02),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("(0/8)",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
