import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CricketTeamDetasilsInput extends StatefulWidget {
  const CricketTeamDetasilsInput({Key? key}) : super(key: key);

  @override
  State<CricketTeamDetasilsInput> createState() =>
      _CricketTeamDetasilsInputState();
}

class _CricketTeamDetasilsInputState extends State<CricketTeamDetasilsInput> {
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
                    MediaQuery.of(context).size.height / 2.5,
                margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                                  width: 42,
                                  height: 35,
                                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: FlatButton(
                                    onPressed: () {},
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
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                                  width: 42,
                                  height: 35,
                                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: FlatButton(
                                    onPressed: () {},
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
                        height: 70,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text("Next"),
                          color: Color(0xffD15858),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
