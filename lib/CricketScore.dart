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
                child: const Text("<",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              _header(),
              Positioned(
                top: h * 0.18,
                left: w * 0.56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  onPressed: () {
                    print("Match Result pressed");
                  },
                  child: const Text(
                    "Match Result >",
                    // "Match Results >",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              _score(),
              Positioned(
                top: h * 0.39,
                left: w * 0.11,
                child: const Text(
                  "Team A won the toss and elected to bat first",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              _scoreCard(),
              _bowlerCard(),
              _keyBoard(),
              _keyBoard2(),
              _keyBoard3(),
              _submit()
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
      top: h * 0.11,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
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
            child: const Icon(
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
      top: h * 0.27,
      left: w * 0.4,
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: const Text("0/0",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: h * 0.02),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
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

  _scoreCard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.45,
      left: h * 0.02,
      right: 20,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            width: w * 0.4,
            height: h * 0.07,
            child: ElevatedButton(
              child: Text("Aniket Mudpe \n0(0)"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color.fromRGBO(255, 255, 255, 0.4)),
              onPressed: () {
                print("Pressed");
              },
            )),
        Container(
            width: w * 0.4,
            height: h * 0.07,
            child: ElevatedButton(
              child: Text("Hiren Thacker\n0(0)"),
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color.fromRGBO(255, 255, 255, 0.4)),
              onPressed: () {
                print("Pressed");
              },
            )),
      ]),
    );
  }

  _bowlerCard() {
    double h = MediaQuery.of(context).size.height;
    return Positioned(
      top: h * 0.58,
      left: h * 0.03,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Jay Pokar",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            '0-0-0-0',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _keyBoard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.65,
      left: 50,
      right: w * 0.1,
      child: Container(
        // color: Colors.white.withOpacity(0.4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("0"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("1"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("2"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("Undo"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
        ]),
      ),
    );
  }

  _keyBoard2() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.74,
      left: 50,
      right: w * 0.1,
      child: Container(
        // color: Colors.white.withOpacity(0.4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("3"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("4"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("6"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("5,7"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
        ]),
      ),
    );
  }

  _keyBoard3() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.83,
      left: 50,
      right: w * 0.1,
      child: Container(
        // color: Colors.white.withOpacity(0.4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("WD"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("NB"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text("BYE"),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.red),
                onPressed: () {
                  print("Pressed");
                },
              )),
          Container(
              width: 70,
              height: 60,
              child: ElevatedButton(
                child: Text(
                  "Out",
                  style: TextStyle(color: Colors.red),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.white),
                onPressed: () {
                  print("Pressed");
                },
              )),
        ]),
      ),
    );
  }

  _submit() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Positioned(
        top: h * 0.92,
        left: w * 0.2,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Color(0xFFD15858)),
            onPressed: () {},
            child: Container(
                width: 221,
                height: 54,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )),
          ),
        ));
  }
}
