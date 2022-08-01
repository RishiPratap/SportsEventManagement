import 'package:ardent_sports/CricketStrickerAndNonStrickerDetails.dart';
import 'package:flutter/material.dart';

class CricketTossDetails extends StatefulWidget {
  const CricketTossDetails({Key? key}) : super(key: key);

  @override
  State<CricketTossDetails> createState() => _CricketTossDetailsState();
}

class _CricketTossDetailsState extends State<CricketTossDetails> {
  @override
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
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "Toss Won By",
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
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Team A",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Team B",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "elected to",
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
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Bat",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Bowl",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CricketStrickerAndNonStrickerDetails()),
                              );
                            },
                            child: Text("Next"),
                            color: Color(0xffD15858),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
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
