import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'SignUpPage.dart';
import 'package:page_transition/page_transition.dart';

Future<http.Response> createAlbum(String emailid, String password) {
  return http.post(
    Uri.parse('https://ardentsportsapis.herokuapp.com/userLogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'loginid': emailid,
      'pwd': password,
    }),
  );
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class login extends StatelessWidget {
  final emaild = TextEditingController();
  final password = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;
    double cardheight = 340.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: deviceWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/login.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Expanded(
                    child: Image.asset("assets/AARDENT.png"),
                  ),
                ),
                Center(
                  child: Expanded(
                    child: Container(
                      height: cardheight,
                      width: 400.0,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white.withOpacity(0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                              child: Expanded(
                                child: TextFormField(
                                  controller: emaild,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    hintText: '  Email/Mobile',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                              child: Expanded(
                                child: TextField(
                                  obscureText: true,
                                  controller: password,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              margin: EdgeInsets.fromLTRB(
                                  20.0, 0.05 * cardheight, 0, 0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  createAlbum(emaild.text.toString(),
                                      password.text.toString());
                                },
                                color: Color(0xffcf253c),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(10.0),
                                splashColor: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, 0.1 * cardheight, 0, 0),
                              child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Forgot Password ?'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: SignUpPage()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SignUpPage()));
                    },
                    child: const Text('Sign Up >'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white.withOpacity(0.5),
                          textStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Terms & Conditions'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
