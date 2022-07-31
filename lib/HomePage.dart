import 'dart:ui';

import 'package:flutter/material.dart';
import 'Menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              image: AssetImage("assets/Homepage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Expanded(
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
                            image: AssetImage('assets/AARDENT_LOGO.png'),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/Ardent_Sport_Text.png"),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()));
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      color: Colors.white60.withOpacity(0.1),
                      child: Column(
                        //MAIN COLUMN
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Container(
                            margin: EdgeInsets.only(top: 2),
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 20,
                              color: Color(0xff6BB8FF),
                              child: Container(
                                margin: EdgeInsets.only(top: 12),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent
                                              .withOpacity(0.6),
                                          backgroundBlendMode:
                                              BlendMode.darken),
                                      child: Image(
                                        image:
                                            AssetImage("assets/badminton.png"),
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rapid Badminton Challenge",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "GandhiNagar",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "V",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffE74545),
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: Text(
                                          "Spots Left",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/trophy 2.png"),
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Prize money",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                                children: <TextSpan>[
                                              TextSpan(text: "Up to "),
                                              TextSpan(
                                                  text: " ₹",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  )),
                                              TextSpan(
                                                text: " 15,000",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Color(0xffE74545),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: AssetImage("assets/Location.png"),
                                ),
                              ),
                              Text(
                                'EDII, Bhatt circle, Near Apollo \n Hospital, Ahmedabad',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  //NEW CARD HERE //TODO MAKE IT REUSABLE
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      color: Colors.white60.withOpacity(0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Container(
                            margin: EdgeInsets.only(top: 2),
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: SingleChildScrollView(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 20,
                                color: Color(0xff03C289),
                                child: Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent
                                                .withOpacity(0.6),
                                            backgroundBlendMode:
                                                BlendMode.darken),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/Ping Pong.png"),
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rapid Table Tennis Challenge",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Akola",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "V",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffE74545),
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: Text(
                                          "Spots Left",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/trophy 2.png"),
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Prize money",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                                children: <TextSpan>[
                                              TextSpan(text: "Up to "),
                                              TextSpan(
                                                  text: " ₹",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  )),
                                              TextSpan(
                                                text: " 22,000",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Color(0xffE74545),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: AssetImage("assets/Location.png"),
                                ),
                              ),
                              Text(
                                'IMA Hall, Akola',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ], //TODO ADD CALENDAR
                          )
                        ],
                      ),
                    ),
                  ),

                  //3RD CARD
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      color: Colors.white60.withOpacity(0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Container(
                            margin: EdgeInsets.only(top: 2),
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: SingleChildScrollView(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 20,
                                color: Color(0xffD15858),
                                child: Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent
                                                .withOpacity(0.6),
                                            backgroundBlendMode:
                                                BlendMode.darken),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/Ping Pong.png"),
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Box Cricket Challenge",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Akola",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "V",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffE74545),
                                          ),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: Text(
                                          "Spots Left",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 1,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 35),
                                        child: Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/trophy 2.png"),
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Prize money",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 35),
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                                children: <TextSpan>[
                                              TextSpan(text: "Up to "),
                                              TextSpan(
                                                  text: " ₹",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  )),
                                              TextSpan(
                                                text: " 22,000",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Color(0xffE74545),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: AssetImage("assets/Location.png"),
                                ),
                              ),
                              Text(
                                'IMA Hall, Akola',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ], //TODO ADD CALENDAR
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
