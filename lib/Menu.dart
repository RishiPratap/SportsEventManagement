import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:ardent_sports/CreateChallenge.dart';
import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/HostedChallenges.dart';
import 'package:ardent_sports/ScoreAMatch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/AARDENT.png"), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/score 1.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Score a challenge",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Vector.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "My Bookings",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
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
          ],
        ),
      )),
    );
  }
}
