import 'dart:convert';
import 'package:ardent_sports/UserDetails.dart';
import 'package:ardent_sports/api.dart';
import 'package:ardent_sports/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:page_transition/page_transition.dart';

final Details = new UserDetails();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  bool isChecked = false;
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  // _signUp() async {
  //   var data = {
  //     'name': nameController.text,
  //     'email': emailController.text,
  //     'pass': passController.text,
  //   };

  //   var res = await CallApi().postData(data, 'createUser');
  // }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: -50.0,
                  left: 50.0,
                  child: Image(
                    alignment: Alignment.center,
                    image: AssetImage('assets/AARDENT.png'),
                  ),
                ),

                //Can Add SingleChildScrollView
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        color: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 25, bottom: 25),
                          child: Column(
                            children: [
                              Container(
                                // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                child: TextField(
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "MobileNo",
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                // padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                child: TextField(
                                  controller: passController,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                child: TextField(
                                  controller: repassController,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    side: BorderSide(color: Colors.red),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Accept Terms & Conditions',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ButtonTheme(
                                    height: 40.0,
                                    minWidth: 200.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (emailController.text.isNotEmpty &&
                                            mobileController.text.isNotEmpty &&
                                            passController.text.isNotEmpty &&
                                            repassController.text.isNotEmpty) {
                                          if (passController.text.toString() ==
                                              repassController.text
                                                  .toString()) {
                                            Details.EMAIL =
                                                emailController.text.toString();
                                            Details.PHONE = mobileController
                                                .text
                                                .toString();
                                            Details.PWD =
                                                passController.text.toString();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubmitPage()));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Password and Confirm Password must be same"),
                                            ));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "All fields must be entered"),
                                          ));
                                        }
                                      },
                                      color: Colors.red,
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Log In >",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),

                            //Terms and Condition
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
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

class SubmitPage extends StatelessWidget {
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final date_of_birth = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final Academy = TextEditingController();
  final Intersted_Sports = TextEditingController();
  SubmitPage({Key? key}) : super(key: key);

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
                image: AssetImage("assets/login.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.only(
                          left: 25, right: 25, top: 70, bottom: 0),
                      color: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
                              child: Row(
                                children: [
                                  Center(
                                    child: Expanded(
                                      child: Image.asset(
                                          "assets/profile-avatar 1.png"),
                                    ),
                                  ),
                                  Center(
                                    child: Expanded(
                                      child: Text(
                                        "Set Up Your Profile",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: first_name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  First name',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: last_name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  Last Name',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: date_of_birth,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  Date of Birth (dd-mm-yy)',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: state,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  State',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: city,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  City',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: Academy,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText: '  Academy',
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
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: Intersted_Sports,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0)),
                                      hintText:
                                          '  Interested sports(Cricket,Football etc..)',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(Details.EMAIL.toString()),
                            ));
                            if (first_name.text.isNotEmpty &&
                                last_name.text.isNotEmpty &&
                                date_of_birth.text.isNotEmpty &&
                                state.text.isNotEmpty &&
                                city.text.isNotEmpty &&
                                Academy.text.isNotEmpty &&
                                Intersted_Sports.text.isNotEmpty) {
                              Details.NAME = first_name.text.toString() +
                                  " " +
                                  last_name.text.toString();
                              Details.DOB = date_of_birth.text.toString();
                              Details.STATE = state.text.toString();
                              Details.CITY = city.text.toString();
                              Details.SPORTS_ACADEMY = Academy.text.toString();
                              Details.INTERESTED_SPORTS =
                                  Intersted_Sports.text.toString();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("All Fields Must Be Filled"),
                              ));
                            }
                          },
                          color: Color(0xffE74545),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
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
        ));
  }
}
