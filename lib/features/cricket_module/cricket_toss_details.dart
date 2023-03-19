import 'package:flutter/material.dart';
import '../../Helper/constant.dart';
import '../home_page/home_page.dart';
import 'cricket_stricker_and_non_stricker_details.dart';

class CricketTossDetails extends StatefulWidget {
  const CricketTossDetails({Key? key}) : super(key: key);

  @override
  State<CricketTossDetails> createState() => _CricketTossDetailsState();
}

class _CricketTossDetailsState extends State<CricketTossDetails> {
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: deviceWidth * 0.03),
                      child: const Text("₹15,000"),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.all(deviceWidth * 0.02),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.03)),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    children: [
                      const Expanded(
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
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Team A",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Team B",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
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
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Bat",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
                                      color: Colors.black.withOpacity(0.4))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: deviceWidth * 0.15,
                                  margin: EdgeInsets.fromLTRB(
                                      deviceWidth * 0.02,
                                      0,
                                      deviceWidth * 0.02,
                                      0),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Bowl",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.02),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: deviceWidth * 0.15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD15858),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      deviceWidth * 0.04)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CricketStrickerAndNonStrickerDetails()),
                              );
                            },
                            child: const Text("Next"),
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
