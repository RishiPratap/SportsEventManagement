import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CricketChallenge extends StatefulWidget {

  @override
  State<CricketChallenge> createState() => _CricketChallengeState();
}

class _CricketChallengeState extends State<CricketChallenge> {
   @override
  TextEditingController EventName = TextEditingController();
  TextEditingController startdateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController endtime = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController Address = TextEditingController();


  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Homepage.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth * 0.03,
                    ),
                    buildCardEventDetails(deviceWidth),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildCardEventDetails(double deviceWidth) => Card(
    elevation: 10,
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    color: Colors.white.withOpacity(0.1),
    margin: EdgeInsets.only(
        left: deviceWidth * 0.05, right: deviceWidth * 0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: deviceWidth * 0.04,
        ),
        Text(
          "    Event Name",
          style: TextStyle(
            fontSize: deviceWidth * 0.05,
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: TextField(
            controller: EventName,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                  borderSide: BorderSide(),
                ),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                )),
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                  child: TextField(
                    controller: startdateinput,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 0)),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          startdateinput.text = formattedDate.toString();
                        });
                      }
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.01),
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                          borderSide: BorderSide(),
                        ),
                        hintText: "Start Date 📅",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                        )),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                  child: TextField(
                    readOnly: true,
                    controller: enddateinput,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 0)),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          enddateinput.text = formattedDate.toString();
                        });
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.01),
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                          borderSide: BorderSide(),
                        ),
                        hintText: "End Date 📅 ",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                  child: TextField(
                    controller: starttime,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        int hour = pickedTime.hour;
                        int minute = pickedTime.minute;
                        setState(() {
                          starttime.text = "$hour:$minute";
                        });
                        // DateTime parsedTime = DateFormat.jm()
                        //     .parse(pickedTime.format(context).toString());
                        // String formattedTime =
                        //     DateFormat('HH:mm:ss').format(parsedTime);
                        // setState(() {
                        //   starttime.text = formattedTime.toString();
                        // });
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.01),
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                          borderSide: BorderSide(),
                        ),
                        hintText: "Start Time ⏰",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                        )),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                  child: TextField(
                    controller: endtime,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        int hour = pickedTime.hour;
                        int minute = pickedTime.minute;
                        setState(() {
                          endtime.text = "$hour:$minute";
                        });

                        // DateTime parsedTime = DateFormat.jm()
                        //     .parse(pickedTime.format(context).toString());
                        // String formattedTime =
                        //     DateFormat('HH:mm:ss').format(parsedTime);
                        // setState(() {
                        //   endtime.text = formattedTime.toString();
                        // });
                      }
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.01),
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                          borderSide: BorderSide(),
                        ),
                        hintText: "End Time ⏰",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(deviceWidth * 0.02),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: TextField(
            controller: city,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                  borderSide: BorderSide(),
                ),
                hintText: "City",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                )),
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: TextField(
            controller: Address,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                  borderSide: BorderSide(),
                ),
                hintText: "Address",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                )),
          ),
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        SizedBox(
          height: deviceWidth * 0.02,
        ),
        Container(
          width: deviceWidth * 0.8,
          margin: EdgeInsets.fromLTRB(
              deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(deviceWidth * 0.06)),
            ),
            onPressed: () {
              if (EventName.text.isNotEmpty &&
                  startdateinput.text.isNotEmpty &&
                  enddateinput.text.isNotEmpty &
                  starttime.text.isNotEmpty &&
                  endtime.text.isNotEmpty &&
                  city.text.isNotEmpty &&
                  Address.text.isNotEmpty) {
                showDialog(          //  data to be passed to new page
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Succes"),
                        content: Text("Data enter succefully"),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Please fill all the fields"),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              }
            },
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
