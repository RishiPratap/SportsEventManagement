import 'dart:convert';
import 'dart:io';
import 'package:ardent_sports/AgeCategoryItem.dart';
import 'package:ardent_sports/CreateChallengeTicket.dart';
import 'package:ardent_sports/CricketDetailsDataClass.dart';
import 'package:ardent_sports/PoolDetailsItem.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CategoryDetails.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'WebViewSpots.dart';
import 'package:get/get.dart';
import 'orderAPI/ModelOrderID.dart';
import 'orderAPI/serviceWrapper.dart';
import 'CricketDetailsItem.dart';

class CricketPool extends StatefulWidget {
  final String? SportName;
  final String EventManagerName;
  final String EventManagerMobileNo;
  final String? EventType;
  final String EventName;
  final String StartDate;
  final String EndDate;
  final String StartTime;
  final String EndTime;
  final String City;
  final String Address;
  final String? Category;
  final String? AgeCategory;
  final String RegistrationCloses;
  final String NoofCourts;
  final String BreakTime;
  final List<CategorieDetails> AllCategoryDetails;

  const CricketPool(
      {Key? key,
        required this.SportName,
        required this.EventManagerName,
        required this.EventManagerMobileNo,
        required this.EventType,
        required this.EventName,
        required this.StartDate,
        required this.EndDate,
        required this.StartTime,
        required this.EndTime,
        required this.City,
        required this.Address,
        required this.Category,
        required this.AgeCategory,
        required this.RegistrationCloses,
        required this.NoofCourts,
        required this.BreakTime,
        required this.AllCategoryDetails})
      : super(key: key);
  @override
  State<CricketPool> createState() => _CricketPoolState();
}

class CreateChallengeDetails {
  late String ORGANIZER_NAME;
  late String ORGANIZER_ID;
  late String USERID;
  late String TOURNAMENT_ID;
  late String? CATEGORY;
  late String NO_OF_KNOCKOUT_ROUNDS;
  late String ENTRY_FEE;
  late String? GOLD;
  late String? SILVER;
  late String? BRONZE;
  late String? OTHER;
  late String? PRIZE_POOL;
  late String TOURNAMENT_NAME;
  late String CITY;
  late String? TYPE;
  late String LOCATION;
  late String START_DATE;
  late String END_DATE;
  late String START_TIME;
  late String END_TIME;
  late int REGISTRATION_CLOSES_BEFORE;
  late String AGE_CATEGORY;
  late String NO_OF_COURTS;
  late String BREAK_TIME;
  late String? SPORT;

  CreateChallengeDetails(
      {required this.ORGANIZER_NAME,
        required this.ORGANIZER_ID,
        required this.USERID,
        required this.TOURNAMENT_ID,
        required this.CATEGORY,
        required this.NO_OF_KNOCKOUT_ROUNDS,
        required this.ENTRY_FEE,
        required this.GOLD,
        required this.SILVER,
        required this.BRONZE,
        required this.OTHER,
        required this.PRIZE_POOL,
        required this.TOURNAMENT_NAME,
        required this.CITY,
        required this.TYPE,
        required this.LOCATION,
        required this.START_DATE,
        required this.END_DATE,
        required this.START_TIME,
        required this.END_TIME,
        required this.REGISTRATION_CLOSES_BEFORE,
        required this.AGE_CATEGORY,
        required this.NO_OF_COURTS,
        required this.BREAK_TIME,
        required this.SPORT});
  Map<String, dynamic> toMap() {
    return {
      "ORGANIZER_NAME": this.ORGANIZER_NAME,
      "ORGANIZER_ID": this.ORGANIZER_ID,
      "USERID": this.USERID,
      "TOURNAMENT_ID": this.TOURNAMENT_ID,
      "CATEGORY": this.CATEGORY,
      "NO_OF_KNOCKOUT_ROUNDS": this.NO_OF_KNOCKOUT_ROUNDS,
      "ENTRY_FEE": this.ENTRY_FEE,
      "GOLD": this.GOLD,
      "SILVER": this.SILVER,
      "BRONZE": this.BRONZE,
      "OTHER": this.OTHER,
      "PRIZE_POOL": this.PRIZE_POOL,
      "TOURNAMENT_NAME": this.TOURNAMENT_NAME,
      "CITY": this.CITY,
      "TYPE": this.TYPE,
      "LOCATION": this.LOCATION,
      "START_DATE": this.START_DATE,
      "END_DATE": this.END_DATE,
      "START_TIME": this.START_TIME,
      "END_TIME": this.END_TIME,
      "REGISTRATION_CLOSES_BEFORE": this.REGISTRATION_CLOSES_BEFORE,
      "AGE_CATEGORY": this.AGE_CATEGORY,
      "NO_OF_COURTS": this.NO_OF_COURTS,
      "BREAK_TIME": this.BREAK_TIME,
      "SPORT": this.SPORT
    };
  }
}

class details {
  late String PoolSize;
  late String TeamSize;
  late String Substitute;
  late String EntryFee;
  late String BallType;
  late String Overs;

  details({
    required this.PoolSize,
    required this.TeamSize,
    required this.Substitute,
    required this.EntryFee,
    required this.BallType,
    required this.Overs,
  });
}

class _CricketPoolState extends State<CricketPool> {
  PageController pageController = PageController(viewportFraction: 0.9);
  double _currPageValue = 0.0;
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

  List<String> PerMatchEstimatedTime = ['5', '10', '20', '30', '60'];
  String? SelectedPerMatchEstimatedTime;

  List<details>? poolDetails = [];
  List<CricketDetailsItem> pools = [];

  bool isPaymentDone = false;

  final EntryFeeController = TextEditingController();
  // final PrizePoolController = TextEditingController();

  final gold = TextEditingController();
  final silver = TextEditingController();
  final bronze = TextEditingController();
  final others = TextEditingController();

  late Razorpay _razorpay;
  var tournament_id_arr;

  @override
  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('paymentDone', true);
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });

    for (CategorieDetails details in widget.AllCategoryDetails) {
      var poolData = CricketDetailsDataClass();
      pools.add(CricketDetailsItem(
        details: details,
        pooldata: poolData,
      ));
    }
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Homepage.png"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: pools.length,
                itemBuilder: (_, i) => pools[i],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(
                      deviceWidth * 0.04,
                      deviceWidth * 0.02,
                      deviceWidth * 0.04,
                      deviceWidth * 0.02),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: /*isPaymentDone == false
                    ? null
                    :*/
                    () async {
                  var data = pools.map((it) => it.pooldata).toList();

                  String poolsize_details = "";
                  String entryfee_details = "";
                  for (int i = 0; i < data.length; i++) {
                    poolsize_details += data[i].PoolSize;
                    entryfee_details += pools[i].pooldata.EntryFee;
                    if (i != pools.length - 1) {
                      poolsize_details += "-";
                      entryfee_details += "-";
                    }
                  }
                  EasyLoading.show(
                    status: 'Loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  var obtianedEmail = prefs.getString('email');
                  print(obtianedEmail);
                  String Category = "";
                  String AgeCategory = "";
                  for (int i = 0; i < widget.AllCategoryDetails.length; i++) {
                    Category += widget.AllCategoryDetails[i].CategoryName;
                    AgeCategory += widget.AllCategoryDetails[i].AgeCategory;
                    if (i != widget.AllCategoryDetails.length - 1) {
                      Category += "-";
                      AgeCategory += "-";
                    }
                  }
                  print(Category);
                  print(widget.EventName);
                  print(widget.City);

                  final ChallengeDetails = CreateChallengeDetails(
                      ORGANIZER_NAME: widget.EventManagerName,
                      ORGANIZER_ID: widget.EventManagerMobileNo,
                      USERID: obtianedEmail!.trim(),
                      TOURNAMENT_ID: "123456",
                      CATEGORY: Category,
                      NO_OF_KNOCKOUT_ROUNDS: poolsize_details,
                      ENTRY_FEE: entryfee_details,
                      GOLD: "0",
                      SILVER: "0",
                      BRONZE: "0",
                      OTHER: "0",
                      PRIZE_POOL: "0",
                      TOURNAMENT_NAME: widget.EventName,
                      CITY: widget.City,
                      TYPE: widget.EventType,
                      LOCATION: widget.Address,
                      START_DATE: widget.StartDate,
                      END_DATE: widget.EndDate,
                      START_TIME: widget.StartTime,
                      END_TIME: widget.EndTime,
                      REGISTRATION_CLOSES_BEFORE: 6,
                      AGE_CATEGORY: AgeCategory,
                      NO_OF_COURTS: "1",
                      BREAK_TIME: widget.BreakTime,
                      SPORT: widget.SportName);
                  final DetailMap = ChallengeDetails.toMap();
                  final json = jsonEncode(DetailMap);
                  print(json);
                  // var url =
                  //     "http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/createMultipleTournament";
                  var url = "https://localhost:5000/createmMultipleTournament";

                  try {
                    var response = await post(Uri.parse(url),
                        headers: {
                          "Accept": "application/json",
                          "Content-Type": "application/json"
                        },
                        body: json,
                        encoding: Encoding.getByName("utf-8"));
                    Map<String, dynamic> jsonData = jsonDecode(response.body);
                    debugPrint('Response body:$json');
                    print(jsonData["TOURNAMENT_ID"]);
                    tournament_id_arr =
                        jsonData["TOURNAMENT_ID"].toString().split(',');
                    if (response.statusCode == 200) {
                      EasyLoading.dismiss();
                      Get.to(CreateChallengeTicket(
                        Tournament_ID: tournament_id_arr,
                        CategorieNames: widget.AllCategoryDetails,
                      ));
                      EasyLoading.dismiss();
                    } else {
                      EasyLoading.dismiss();
                      EasyLoading.showError("Error in Tournament Creation");
                    }
                  } catch (e) {
                    print(e);
                    EasyLoading.showError(e.toString());
                    EasyLoading.dismiss();
                  }
                },
                child: Text("Create Tournament",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.fromLTRB(
                      deviceWidth * 0.04,
                      deviceWidth * 0.02,
                      deviceWidth * 0.04,
                      deviceWidth * 0.02),
                ),
                child: Text("Make Payment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                onPressed: isPaymentDone == true
                    ? null
                    : () {
                  _getorderId('2');
                }),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  _getorderId(String amount) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black, status: 'Loading...');
    print(" call start here");
    servicewrapper wrapper = new servicewrapper();
    Map<String, dynamic> response = await wrapper.call_order_api(amount);
    final model = ModelOrderID.fromJson(response);
    print(" response here");
    if (model != null) {
      if (model.status == 1) {
        EasyLoading.dismiss();
        print(" order id is  - " + model.orderID.toString());
        _startPayment(model.orderID.toString(), amount);
      } else {
        print(" status zero");
      }
    } else {
      print(" model null for category api");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    setState(() {
      isPaymentDone = true;
    });
    print(
        " RazorSuccess : " + response.paymentId! + " -- " + response.orderId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(" RazorpayError : " +
        response.code.toString() +
        " -- " +
        response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(" RazorWallet : " + response.walletName!);
  }

  _startPayment(String orderID, String amount) {
    var options = {
      //rzp_live_4JAecB352A9wtt
      'key': 'rzp_live_4JAecB352A9wtt',
      'amount': '2',
      'order_id': orderID,
      'name': 'Ardent Sports',
      'description': 'Payment for Spot Booking',
      'prefill': {'contact': '9999999999', 'email': 'ardentsports1@gmail.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(" razorpay error " + e.toString());
    }
  }
}
