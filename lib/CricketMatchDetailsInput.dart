import 'package:ardent_sports/CricketTeamDetailsInput.dart';
import 'package:flutter/material.dart';

class CricketMatchDetailsInput extends StatefulWidget {
  const CricketMatchDetailsInput({Key? key}) : super(key: key);

  @override
  State<CricketMatchDetailsInput> createState() =>
      _CricketMatchDetailsInputState();
}

class _CricketMatchDetailsInputState extends State<CricketMatchDetailsInput> {
  List<String> overs = ['1', '5', '10', '20', '50'];
  String? SelectedOver = "1";

  List<String> teamsizes = ['1', '5', '10', '11'];
  String? Selectedteamsize = "1";

  List<String> substitutes = ['1', '2', '3', '4', '5'];
  String? Selectedsubstitute = "1";

  List<String> balltypes = ['Kokaburra', 'Dukes', 'SG'];
  String? Selectedballtype = "Dukes";

  TextEditingController city = TextEditingController();
  TextEditingController match_name = TextEditingController();

  @override
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
                  image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Image.asset("assets/back.png"),
                    ),
                    Container(
                      width: deviceWidth * 0.07,
                      height: deviceWidth * 0.1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/AARDENT_LOGO.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                    Container(
                      width: deviceWidth * 0.26,
                      height: deviceWidth * 0.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Ardent_Sport_Text.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 3,
                  margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                      deviceWidth * 0.1, deviceWidth * 0.02, 0),
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceWidth * 0.03)),
                      color: Colors.white.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: deviceWidth * 0.04,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("    No of overs"),
                                ),
                                DropdownButton<String>(
                                  value: SelectedOver,
                                  items: overs
                                      .map((over) => DropdownMenuItem<String>(
                                            value: over,
                                            child: Text("   $over"),
                                          ))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => SelectedOver = item),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.02,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("    Playing team size"),
                                ),
                                DropdownButton<String>(
                                  value: Selectedteamsize,
                                  items: teamsizes
                                      .map((size) => DropdownMenuItem<String>(
                                            value: size,
                                            child: Text("   $size"),
                                          ))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => Selectedteamsize = item),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.02,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("    Substitutes"),
                                ),
                                DropdownButton<String>(
                                  value: Selectedsubstitute,
                                  items: substitutes
                                      .map((substitute) =>
                                          DropdownMenuItem<String>(
                                            value: substitute,
                                            child: Text("   $substitute"),
                                          ))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => Selectedsubstitute = item),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.02,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("    Ball Type"),
                                ),
                                DropdownButton<String>(
                                  value: Selectedballtype,
                                  items: balltypes
                                      .map((balltype) =>
                                          DropdownMenuItem<String>(
                                            value: balltype,
                                            child: Text("   $balltype"),
                                          ))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => Selectedballtype = item),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.02,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: TextField(
                              controller: city,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02)),
                                hintText: 'City',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.02),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.001)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.02),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.001),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: deviceWidth * 0.15,
                            margin: EdgeInsets.fromLTRB(deviceWidth * 0.02,
                                deviceWidth * 0.02, deviceWidth * 0.02, 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(deviceWidth * 0.02),
                                color: Colors.black.withOpacity(0.4)),
                            child: TextField(
                              controller: match_name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        deviceWidth * 0.02)),
                                hintText: 'Match Name :',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.02),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.001)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(deviceWidth * 0.02),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.001),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 8,
                              child: Container(
                                width: double.infinity,
                              )),
                          Expanded(
                            flex: 7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(deviceWidth * 0.04, 0,
                                  deviceWidth * 0.04, deviceWidth * 0.02),
                              height: deviceWidth * 0.08,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Color(0xffE74545),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(
                                        deviceWidth * 0.04),
                                  ),
                                ),
                                onPressed: () {
                                  if (city.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Please Enter the city name"),
                                      ),
                                    );
                                  } else if (match_name.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Please Enter the Match Name"),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CricketTeamDetasilsInput(
                                          no_of_overs: SelectedOver!,
                                          playing_team_size: Selectedteamsize!,
                                          Substitutes: Selectedsubstitute!,
                                          ball_type: Selectedballtype!,
                                          city: city.text,
                                          match_name: match_name.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text("Next"),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            )),
      ),
    );
  }
}
