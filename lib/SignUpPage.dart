import 'dart:convert';
import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

TextEditingController passController = TextEditingController();
TextEditingController repassController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController mobileController = TextEditingController();

class _SignUpPage extends State<SignUpPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  alignment: Alignment.center,
                  image: AssetImage('assets/AARDENT.png'),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  margin: EdgeInsets.only(
                      left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                  color: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.04)),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: deviceWidth * 0.03,
                        right: deviceWidth * 0.03,
                        top: deviceWidth * 0.05,
                        bottom: deviceWidth * 0.05),
                    child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth * 0.06,
                        ),
                        Container(
                          child: TextField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "MobileNo",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth * 0.06,
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                          child: TextField(
                            controller: passController,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth * 0.06,
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                          child: TextField(
                            controller: repassController,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.06),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth * 0.02,
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
                                  fontSize: deviceWidth * 0.045,
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
                              height: deviceWidth * 0.1,
                              minWidth: deviceWidth * 0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (emailController.text.trim().isNotEmpty &&
                                      mobileController.text.trim().isNotEmpty &&
                                      passController.text.trim().isNotEmpty &&
                                      repassController.text.trim().isNotEmpty) {
                                    if (passController.text.toString().trim() ==
                                        repassController.text
                                            .toString()
                                            .trim()) {
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
                                      content:
                                          Text("All fields must be entered"),
                                    ));
                                  }
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffE74545),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          deviceWidth * 0.06)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Log In >",
                      style: TextStyle(
                        color: Color(0xffE74545),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    )),
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
          ),
        ),
      ),
    );
  }
}

class SubmitPage extends StatefulWidget {
  SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final first_name = TextEditingController();

  final last_name = TextEditingController();

  final date_of_birth = TextEditingController();

  final state = TextEditingController();

  final city = TextEditingController();

  final Academy = TextEditingController();

  final Intersted_Sports = TextEditingController();

  List<String> gender = ['Male', 'Female'];

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05,
                          top: deviceWidth * 0.2,
                          bottom: 0),
                      color: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04)),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.06,
                                  deviceWidth * 0.02, deviceWidth * 0.06, 0),
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
                                          fontSize: 22.0,
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: TextFormField(
                                    controller: first_name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  First name',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: TextFormField(
                                    controller: last_name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  Last Name',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: TextFormField(
                                    controller: date_of_birth,
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);
                                        setState(() {
                                          date_of_birth.text =
                                              formattedDate.toString();
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  Date of Birth (dd-mm-yy)',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: TextFormField(
                                    controller: state,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  State',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: TextFormField(
                                    controller: city,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  City',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04,
                                  deviceWidth * 0.02, deviceWidth * 0.04, 0),
                              child: Expanded(
                                child: Container(
                                  height: deviceWidth * 0.14,
                                  child: DropdownButtonFormField(
                                    value: selectedGender,
                                    items: gender
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value),
                                              value: value,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value as String;
                                      });
                                    },
                                    hint: Text("Select Gender",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontSize: deviceWidth * 0.04,
                                        )),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.red,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              deviceWidth * 0.06)),
                                      hintText: '  Gender',
                                      hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            deviceWidth * 0.06),
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
                      margin: EdgeInsets.fromLTRB(0, deviceWidth * 0.05, 0, 0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var obtianedEmail =
                                prefs.setString('email', emailController.text);

                            if (first_name.text.trim().isNotEmpty &&
                                last_name.text.trim().isNotEmpty &&
                                date_of_birth.text.isNotEmpty &&
                                state.text.isNotEmpty &&
                                city.text.isNotEmpty &&
                                selectedGender!.isNotEmpty) {
                              final Details = UserDetails(
                                  USERID: emailController.text.toString(),
                                  PHONE: mobileController.text.toString(),
                                  NAME: first_name.text.toString(),
                                  EMAIL: emailController.text.toString(),
                                  PWD: passController.text.toString(),
                                  GENDER: selectedGender as String,
                                  DOB: date_of_birth.text.toString(),
                                  CITY: city.text.toString(),
                                  STATE: state.text.toString(),
                                  SPORTS_ACADEMY: "NULL",
                                  PROFILE_ID: emailController.text.toString(),
                                  INTERESTED_SPORTS: "NULL");
                              final DetailMap = Details.toMap();
                              final json = jsonEncode(DetailMap);
                              var url = "http://44.202.65.121:443/createUser";
                              var response = await post(Uri.parse(url),
                                  headers: {
                                    "Accept": "application/json",
                                    "Content-Type": "application/json"
                                  },
                                  body: json,
                                  encoding: Encoding.getByName("utf-8"));

                              final jsonResponse = jsonDecode(response.body);
                              if (jsonResponse['Message'] == "User Exists") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Email Already Exists,please try with different email"),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Successfully Registered"),
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("All Fields Must Be Filled"),
                              ));
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffE74545),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.06)),
                          ),
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
