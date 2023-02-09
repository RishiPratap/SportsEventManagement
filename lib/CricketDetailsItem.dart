import 'package:ardent_sports/CategoryDetails.dart';
import 'package:ardent_sports/CricketDetailsDataClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'WebViewSpots.dart';

class CricketDetailsItem extends StatefulWidget {
  final CategorieDetails details;
  final CricketDetailsDataClass pooldata;
  final state = _CricketDetailsItemState();

  CricketDetailsItem({Key? key, required this.details, required this.pooldata})
      : super(key: key);

  @override
  _CricketDetailsItemState createState() => state;
  bool isValid() => state.validate();
}

class _CricketDetailsItemState extends State<CricketDetailsItem> {
  final form = GlobalKey<FormState>();

  List<String> PoolSizes = ['4', '8', '16', '32', '64'];
  List<String> TeamSizes = ['5','6','7','8','9','10','11','12'];
  List<String> SubstitueSizes = ['2','3','4','5'];
  List<String> BallType = ["Hard Tennis", "Soft Tennis", "Leather", "Other"];

  String? SelectedPoolSize;
  String? SelectedTeamSize;
  String? SelectedSubstitutes;
  String? SelectedBallType;
  String? SelectedPointSystem;
  String? Points;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
      child: Card(
        elevation: 10,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.01),
        ),
        margin: EdgeInsets.only(
            left: deviceWidth * 0.025, right: deviceWidth * 0.025),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      deviceWidth * 0.03, deviceWidth * 0.02, 0, 0),
                  child: Text(
                    "${widget.details.AgeCategory} ${widget.details.CategoryName}",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
                  hint: Text(
                    "Pool Size",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: deviceWidth * 0.04,
                    ),
                  ),
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
                  // value: widget.pooldata.PoolSize,
                  items: PoolSizes.map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  )).toList(),
                  onSaved: (val) => widget.pooldata.PoolSize = val.toString(),
                  value: widget.pooldata.PoolSize,
                  onChanged: (value) {
                    setState(() {
                      widget.pooldata.PoolSize = value as String;
                    });
                  },
                ),
              ),

              //Team Size
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: DropdownButtonFormField(
                  hint: Text(
                    "Team Size",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: deviceWidth * 0.04,
                    ),
                  ),
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
                  // value: widget.pooldata.PoolSize,
                  items: TeamSizes.map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  )).toList(),
                  onSaved: (val) => widget.pooldata.TeamSize = val.toString(),
                  value: widget.pooldata.TeamSize,
                  onChanged: (value) {
                    setState(() {
                      widget.pooldata.TeamSize = value as String;
                    });
                  },
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.04),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.pooldata.EntryFee,
                  onSaved: (val) => widget.pooldata.EntryFee = val.toString(),
                  onChanged: (value) {
                    setState(() {
                      widget.pooldata.EntryFee = value as String;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.04),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      hintText: "Entry Fee",
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w200),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(deviceWidth * 0.02),
                      )),
                ),
              ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
              Row(),
              Container(
                width: deviceWidth * 0.8,
                margin: EdgeInsets.fromLTRB(
                    deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    Get.to(WebViewSpots(spots: widget.pooldata.PoolSize));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(deviceWidth * 0.06)),
                  ),
                  child: Text(
                    'Preview Fixture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   width: deviceWidth * 0.8,
              //   margin: EdgeInsets.fromLTRB(
              //       deviceWidth * 0.04, 0, deviceWidth * 0.03, 0),
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       // EasyLoading.show(
              //       //   status: 'Loading...',
              //       //   maskType: EasyLoadingMaskType.black,
              //       // );
              //       if (PoolSizes.isNotEmpty &&
              //           EntryFeeController.text.isNotEmpty &&
              //           PointSystems.isNotEmpty &&
              //           gold.text.isNotEmpty &&
              //           silver.text.isNotEmpty &&
              //           bronze.text.isNotEmpty &&
              //           !isCategoryDetailsAdded[_currPageValue.toInt()]) {
              //         var pool = details(
              //           PoolSize: SelectedPoolSize!,
              //           gold: gold.text,
              //           silver: silver.text,
              //           bronze: bronze.text,
              //           others: others.text,
              //           entryfee: EntryFeeController.text,
              //           pointsystem: Points!,
              //         );
              //         poolDetails?.add(pool);
              //         setState(() {
              //           String? ok;
              //           gold.text = "";
              //           silver.text = "";
              //           bronze.text = "";
              //           SelectedPoolSize = ok;
              //           EntryFeeController.text = "";
              //           others.text = "";
              //           SelectedPointSystem = ok;
              //           Points = ok;
              //         });
              //         EasyLoading.showInfo(
              //             "Details Have been successfully saved");
              //       } else if (isCategoryDetailsAdded[_currPageValue.toInt()]) {
              //         EasyLoading.showError("Details Have ALredy Been Saved");
              //       } else {
              //         EasyLoading.showError("All fields are required");
              //       }
              //     },
              //     child: Text(
              //       'Submit Category Details',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(deviceWidth * 0.06)),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    form.currentState?.save();
    return true;
  }
}
