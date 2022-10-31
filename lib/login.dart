import 'dart:async';
import 'dart:convert';
import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/PoolDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'SignUpPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  final emaild = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double cardheight = MediaQuery.of(context).size.height * 0.47;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: deviceWidth,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/login.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Image.asset("assets/AARDENT.png"),
                ),
                Center(
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
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emaild,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.08)),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                deviceWidth * 0.04, deviceWidth * 0.04, 0),
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
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: deviceWidth * 0.4,
                            margin: EdgeInsets.fromLTRB(
                                deviceWidth * 0.04, 0.05 * cardheight, 0, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(deviceWidth * 0.03),
                                // splashColor: Colors.grey,
                                backgroundColor: Color(0xffE74545),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.04),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: deviceWidth * 0.05),
                              ),
                              onPressed: () async {
                                EasyLoading.show(
                                    status: 'Loading...',
                                    indicator: const SpinKitThreeBounce(
                                      color: Color(0xFFE74545),
                                    ),
                                    maskType: EasyLoadingMaskType.black);
                                if (emaild.text.trim().isNotEmpty ||
                                    password.text.trim().isNotEmpty) {
                                  final logindetails = LoginDetails(
                                      EmailId: emaild.text.toString().trim(),
                                      Password:
                                          password.text.toString().trim());
                                  final logindetailsmap = logindetails.toMap();
                                  final json = jsonEncode(logindetailsmap);
                                  var url =
                                      "http://44.202.65.121:443/userLogin";
                                  var response = await post(Uri.parse(url),
                                      headers: {
                                        "Accept": "application/json",
                                        "Content-Type": "application/json"
                                      },
                                      body: json,
                                      encoding: Encoding.getByName("utf-8"));
                                  final jsonResponse =
                                      jsonDecode(response.body);
                                  if (jsonResponse['Message'] ==
                                      "USER Verified") {
                                    EasyLoading.dismiss();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Logged in successfully"),
                                    ));
                                    EasyLoading.dismiss();
                                  } else if (jsonResponse['Message'] ==
                                      'Incorrect Pwd') {
                                    final msg = "Incorrect Password";
                                    Fluttertoast.showToast(msg: msg);
                                    EasyLoading.dismiss();
                                  } else if (jsonResponse['Message'] ==
                                      "Invalid USERID") {
                                    final msg = "Invalid UserID";
                                    Fluttertoast.showToast(msg: msg);
                                    EasyLoading.dismiss();
                                  }

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('email', emaild.text);
                                }
                                EasyLoading.dismiss();
                              },
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(0, 0.1 * cardheight, 0, 0),
                            child: Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
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
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withOpacity(0.5),
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Terms & Conditions'),
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
