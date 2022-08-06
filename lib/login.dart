import 'dart:async';
import 'dart:convert';
import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'SignUpPage.dart';
import 'package:page_transition/page_transition.dart';
import 'UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

String? finalEmail;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtianedEmail = prefs.getString('email');
    setState(() {
      finalEmail = obtianedEmail;
    });
    debugPrint("Email: $finalEmail");
  }

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      if (finalEmail == null) {
        Get.to(login());
      } else {
        Get.to(HomePage());
      }
    });
  }

  final emaild = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double cardheight = MediaQuery.of(context).size.height * 0.44;
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.fromLTRB(deviceWidth * 0.04, 0,
                          deviceWidth * 0.04, deviceWidth * 0.04),
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
                              padding: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.04, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: TextField(
                                  controller: emaild,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.08)),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.06),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.04, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: TextField(
                                  obscureText: true,
                                  controller: password,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.08)),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.06),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.4,
                              margin: EdgeInsets.fromLTRB(
                                  deviceWidth * 0.04, 0.05 * cardheight, 0, 0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      deviceWidth * 0.04),
                                ),
                                child: Text(
                                  "Login",
                                  style:
                                      TextStyle(fontSize: deviceWidth * 0.05),
                                ),
                                onPressed: () async {
                                  if (emaild.text.isNotEmpty &&
                                      password.text.isNotEmpty) {
                                    final logindetails = LoginDetails(
                                        EmailId: emaild.text.toString(),
                                        Password: password.text.toString());
                                    final logindetailsmap =
                                        logindetails.toMap();
                                    final json = jsonEncode(logindetailsmap);
                                    var url =
                                        "https://ardentsportsapis.herokuapp.com/userLogin";
                                    var response = await post(Uri.parse(url),
                                        headers: {
                                          "Accept": "application/json",
                                          "Content-Type": "application/json"
                                        },
                                        body: json,
                                        encoding: Encoding.getByName("utf-8"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Logged in successfully"),
                                    ));

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('email', emaild.text);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                },
                                color: Color(0xffE74545),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(deviceWidth * 0.03),
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
                      primary: Color(0xffE74545),
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
