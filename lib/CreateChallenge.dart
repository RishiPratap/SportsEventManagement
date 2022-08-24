import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'EventDetails.dart';

class CreateChallenge extends StatefulWidget {
  const CreateChallenge({Key? key}) : super(key: key);

  @override
  State<CreateChallenge> createState() => _CreateChallengeState();
}

class _CreateChallengeState extends State<CreateChallenge> {
  List<String> Sports = ['Badminton', 'Table Tennis', 'Cricket'];
  String? SelectedSport;

  List<String> Event = ['Fixed', 'Dynamic'];
  String? SelectedEvent;

  final EventManagerNameController = TextEditingController();
  final MobileNumberController = TextEditingController();

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
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: deviceWidth * 0.2,
                ),
                Text(
                  "Create Competition",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: deviceWidth * 0.05,
                  ),
                ),
                SizedBox(
                  height: deviceWidth * 0.02,
                ),
                buildCard(deviceWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(double deviceWidth) => Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.01),
        ),
        color: Colors.white.withOpacity(0.1),
        margin: EdgeInsets.only(
            left: deviceWidth * 0.05, right: deviceWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceWidth * 0.04,
              ),
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: DropdownButtonFormField(
                  hint: Text("Select Sport(BD,TT,Cric)",
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.06),
                      )),
                  value: SelectedSport,
                  items: Sports.map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      )).toList(),
                  onChanged: (value) {
                    setState(() {
                      SelectedSport = value as String;
                    });
                  },
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                child: Text(
                  "Event Manager Detail",
                  style: TextStyle(
                    fontSize: deviceWidth * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: deviceWidth * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: EventManagerNameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.04),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.04),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                        decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.04)),
                        child: TextField(
                          maxLength: 10,
                          controller: MobileNumberController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.04),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.04),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Mobile Number",
                              counterText: "",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth * 0.02,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please Select a Event';
                    } else {
                      return null;
                    }
                  },
                  alignment: Alignment.bottomCenter,
                  hint: Text("Event Type",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                      )),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  value: SelectedEvent,
                  items: Event.map((value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                        ),
                        value: value,
                      )).toList(),
                  onChanged: (value) {
                    setState(() {
                      SelectedEvent = value as String;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Event Type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.06),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.03, 10, deviceWidth * 0.03, 0),
                child: Text(
                  "Event Type",
                  style: TextStyle(
                      fontSize: deviceWidth * 0.05,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
                child: Card(
                  color: Colors.black.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceWidth * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                        child: Text(
                          "Fixed Event: Prize Money is fixed irrespective of the number of players joining the challenge.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                        child: Text(
                          "Dynamic Event:Prize money increases with increase in number of players joining the challenge.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: deviceWidth * 0.04,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 0.8,
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                child: RaisedButton(
                  onPressed: () {
                    if (SelectedSport == null ||
                        SelectedEvent == null ||
                        EventManagerNameController.text.isEmpty ||
                        MobileNumberController.text.isEmpty) {
                      final msg = "All Fields are Mandatory";
                      Fluttertoast.showToast(msg: msg);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventDetails(
                                    SportName: SelectedSport,
                                    EventManagerName:
                                        EventManagerNameController.text,
                                    EventManagerMobileNo:
                                        MobileNumberController.text,
                                    EventType: SelectedEvent as String,
                                  )));
                      print(SelectedEvent);
                      print(SelectedSport);
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.06)),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
            ],
          ),
        ),
      );
}
