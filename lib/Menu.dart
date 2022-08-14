import 'package:ardent_sports/CreateChallenge.dart';

import 'package:ardent_sports/HostedChallenges.dart';
import 'package:ardent_sports/MyBookings.dart';
import 'package:ardent_sports/ScoreAMatch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LiveMaintainer.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth * 0.4,
                height: deviceWidth * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/AARDENT.png"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/gear.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/plus.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateChallenge()));
                      },
                      child: Text(
                        "Create Challenge",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/score 1.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(LiveMaintainer());
                      },
                      child: Text(
                        "Score a challenge",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/score 1.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScoreAMatch()));
                      },
                      child: Text(
                        "Score a Match",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.06,
                    height: deviceWidth * 0.06,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Vector.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(MyBookings());
                      },
                      child: Text(
                        "My Bookings",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Vecto1.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(HostedChallenges());
                      },
                      child: Text(
                        "My Hosted Challenges",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/contacts.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Contact Us",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: deviceWidth * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth * 0.08,
                    height: deviceWidth * 0.08,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  TextButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
