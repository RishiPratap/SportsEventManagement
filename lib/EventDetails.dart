import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'PoolDetails.dart';

class EventDetails extends StatefulWidget {
  final String? SportName;
  final String EventManagerName;
  final String EventManagerMobileNo;
  final String? EventType;
  const EventDetails(
      {Key? key,
      required this.SportName,
      required this.EventManagerName,
      required this.EventManagerMobileNo,
      required this.EventType})
      : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  TextEditingController EventName = TextEditingController();
  TextEditingController startdateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  TextEditingController registrationclosedateinput = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController endtime = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Category = TextEditingController();
  TextEditingController AgeCategory = TextEditingController();
  TextEditingController noofcourts = TextEditingController();
  TextEditingController breaktime = TextEditingController();

  late DateTime dateStart = DateTime.now().subtract(const Duration(days: 0));
  late DateTime dateEnd = DateTime.now();

  _validate() {
    if (dateEnd.isBefore(dateStart)) {
      Fluttertoast.showToast(msg: "End date should be greater than start date");
    } else {
      DateTime(2100);
    }
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
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
                              firstDate: dateStart,
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
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            setState(() {
                              starttime.text = formattedTime.toString();
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
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            setState(() {
                              endtime.text = formattedTime.toString();
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
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.03, 0, deviceWidth * 0.03, 0),
              child: Card(
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceWidth * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04)),
                      child: TextField(
                        controller: Category,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(),
                            // ),
                            hintText: "Category",
                            hintStyle: TextStyle(color: Colors.white),
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
                          deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.04)),
                      child: TextField(
                        controller: AgeCategory,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.04),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(),
                            // ),
                            hintText: "Age Category",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => EventDetails()));
                      },
                      color: Colors.red,
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.06)),
                    ),
                    Row(
                      children: [
                        Text("  "),
                        Image(image: AssetImage("assets/Menu.png")),
                        Text("     MS OPEN"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("  "),
                        Image(image: AssetImage("assets/Menu.png")),
                        Text("     WS OPEN"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("  "),
                        Image(image: AssetImage("assets/Menu.png")),
                        Text("     WS OPEN"),
                      ],
                    ),
                    SizedBox(
                      height: deviceWidth * 0.02,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
              child: TextField(
                controller: registrationclosedateinput,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
                style: TextStyle(color: Colors.white),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      registrationclosedateinput.text =
                          formattedDate.toString();
                    });
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.01),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Registration Closes",
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
                      controller: noofcourts,
                      keyboardType: TextInputType.number,
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
                          hintText: "No of Courts",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.02),
                          )),
                    ),
                  )),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          deviceWidth * 0.02, 0, deviceWidth * 0.02, 0),
                      child: TextField(
                        controller: breaktime,
                        keyboardType: TextInputType.number,
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
                            hintText: "Break Time (In Minutes)",
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
              width: deviceWidth * 0.8,
              margin: EdgeInsets.fromLTRB(
                  deviceWidth * 0.04, 0, deviceWidth * 0.04, 0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PoolDetails(
                                SportName: widget.SportName,
                                EventManagerName: widget.EventManagerName,
                                EventManagerMobileNo:
                                    widget.EventManagerMobileNo,
                                EventType: widget.EventType,
                                EventName: EventName.text,
                                StartDate: startdateinput.text,
                                EndDate: enddateinput.text,
                                RegistrationCloses:
                                    registrationclosedateinput.text,
                                StartTime: starttime.text,
                                EndTime: endtime.text,
                                City: city.text,
                                Address: Address.text,
                                Category: Category.text,
                                AgeCategory: AgeCategory.text,
                                NoofCourts: noofcourts.text,
                                BreakTime: breaktime.text,
                              )));
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
          ],
        ),
      );
}
