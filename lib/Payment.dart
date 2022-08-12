import 'dart:convert';
import 'dart:developer' as developer;
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Payment extends StatefulWidget {
  final String Spot_Price;
  final String Spot_Number;
  final Socket socket;
  final String btnId;
  final String tourneyId;
  final String? location;
  final String? eventName;
  final String? category;
  final String? sport;
  final String? name;
  final String date;

  Payment({
    Key? key,
    required this.Spot_Price,
    required this.Spot_Number,
    required this.socket,
    required this.btnId,
    required this.tourneyId,
    required this.location,
    required this.eventName,
    required this.category,
    required this.sport,
    required this.name,
    required this.date,
  }) : super(key: key);
  @override
  State<Payment> createState() => _PaymentState();
}

class Tourney_Id {
  late String TOURNAMENT_ID;
  late String btnId;
  String? USER;
  Tourney_Id(
      {required this.TOURNAMENT_ID, required this.btnId, required this.USER});
  Map<String, dynamic> toMap() {
    return {
      "TOURNAMENT_ID": this.TOURNAMENT_ID,
      "btnId": this.btnId,
      "USERID": this.USER
    };
  }
}

class _PaymentState extends State<Payment> {
  bool isDebitLoading = false;
  bool isCreditLoading = false;
  bool loading = false;
  bool gPayLoading = false;
  bool phonePayLoading = false;
  bool paytmLoading = false;

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  var url = 'https://ardentsportsapis.herokuapp.com/makePayment';
  Future<void> initPaymentSheet(context,
      {required String email, required int amount}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'amount': amount.toString(),
          'spot_number': widget.Spot_Number,
        },
      );

      debugPrint('Amount: $amount');
      debugPrint("Spot Number: ${widget.Spot_Number}");

      final jsonResponse = jsonDecode(response.body);
      debugPrint('Response Logged: $jsonResponse');
      debugPrint("Success: ${jsonResponse['success']}");

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Ardent Sports',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        style: ThemeMode.system,
        testEnv: true,
        googlePay: true,
        merchantCountryCode: 'IN',
      ));

      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful!")),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var obtianedEmail = prefs.getString('email');
      final tourneyID = Tourney_Id(
          TOURNAMENT_ID: widget.tourneyId,
          btnId: widget.btnId,
          USER: obtianedEmail);

      final tourneyID1Map = tourneyID.toMap();
      final json_tourneyid = jsonEncode(tourneyID1Map);

      if (jsonResponse['success'] == 'true') {
        widget.socket.emit('confirm-booking', json_tourneyid);
      }

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: ticket(
                spotNo: widget.Spot_Number,
                location: widget.location,
                eventName: widget.eventName,
                sportName: widget.sport,
                name: widget.name,
                category: widget.category,
                date: widget.date,
              )));
    } catch (e) {
      debugPrint('Error:$e');
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              content: Text('Due to some issues, ${e.error.localizedMessage}')),
        );
      } else {
        developer.log('Error:$e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error:$e')));
      }
    }
  }

  Widget build(BuildContext context) {
    var amount = widget.Spot_Price;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: h,
          child: Stack(
            children: [
              _header(w),
              _transparentImage(w),
              _cards(w),
              _cc(w),
              _text(w),
              _paymentContainer(w),
              _upiPayments(w),
              _couponCode(w),
              Positioned(
                left: w * 0.4,
                top: w * 0.42,
                child: Text(
                  "PAYMENT",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                left: w * 0.4,
                top: w * 0.48,
                child: Text(
                  '₹ $amount',
                  style: TextStyle(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                left: w * 0.17,
                top: w * 0.8,
                child: Text(
                  "DEBIT CARD",
                  style: TextStyle(
                      color: Color(0xffD15858),
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                right: w * 0.17,
                top: w * 0.8,
                child: Text(
                  "CREDIT CARD",
                  style: TextStyle(
                      color: Color(0xffD15858),
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                left: w * 0.252,
                top: w * 0.148,
                child: Text(
                  "Proceed To Pay",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Positioned(
                  left: w * 0.048,
                  top: w * 0.1,
                  child: TextButton(
                    child: Text(
                      "<",
                      style: TextStyle(
                          fontSize: w * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _header(double w) {
    return SizedBox(
      height: w * 0.5,
      child: Stack(children: [
        _backgroundImage(w),
      ]),
    );
  }

  _backgroundImage(double w) {
    return Positioned(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(w * 0.08),
              bottomRight: Radius.circular(w * 0.08),
            ),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/Rectangle 79.png"))),
      ),
    );
  }

  _transparentImage(double w) {
    return Positioned(
      top: w * 0.36,
      left: w * 0.01,
      child: Container(
        // margin: EdgeInsets.fromLTRB(75, 0, 0, 0),
        // padding: EdgeInsets.all(15.0),
        height: w * 0.56,
        width: MediaQuery.of(context).size.width - 10,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(w * 0.04)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/transparent.png"))),
      ),
    );
  }

  _cards(double w) {
    return Positioned(
      top: w * 0.6,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: w * 0.26,
            width: w * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(w * 0.02)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/Rectangle 80.png"))),
          ),
          //SizedBox(width: 10),
          Container(
            height: w * 0.264,
            width: w * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(w * 0.02)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/Rectangle 80.png"))),
          ),
        ],
      ),
    );
  }

  _cc(double w) {
    return Positioned(
        top: w * 0.60,
        left: 0,
        right: 0,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            isDebitLoading
                ? CircularProgressIndicator(
                    color: Colors.red,
                  )
                : TextButton(
                    onPressed: () async {
                      setState(() {
                        isDebitLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);

                      setState(() {
                        isDebitLoading = false;
                      });
                      print("After await");
                    },
                    child: Container(
                      //DEBIT CARD
                      padding: EdgeInsets.fromLTRB(0, w * 0.01, 0, 0),
                      margin: EdgeInsets.only(right: w * 0.01),
                      height: MediaQuery.of(context).size.width * 0.17,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(w * 0.02)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/Credit.png"))),
                    ),
                  ),
            // Spacer(),
            //SizedBox(width: 10),
            isCreditLoading
                ? CircularProgressIndicator(
                    color: Colors.red,
                  )
                : TextButton(
                    onPressed: () async {
                      setState(() {
                        isCreditLoading = true;
                      });
                      developer.log('Before Await');
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);
                      developer.log("Afeter Await");
                      setState(() {
                        isCreditLoading = false;
                      });
                    },
                    child: Container(
                      //DEBIT CARD
                      padding: EdgeInsets.fromLTRB(0, w * 0.02, 0, 0),
                      margin: EdgeInsets.only(right: w * 0.01),
                      height: MediaQuery.of(context).size.width * 0.17,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(w * 0.02)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/Credit.png"))),
                    ),
                  ),
          ],
        ));
  }

  _text(double w) {
    return Container(
      child: Positioned(
          top: w * 0.93,
          left: w * 0.04,
          child: Text("Other Payment Modes",
              style: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
    );
  }

  _upiPayments(double w) {
    return Positioned(
      top: MediaQuery.of(context).size.width * 1.04,
      right: w * 0.03,
      child: Column(
        children: [
          SizedBox(
            height: w * 0.1,
            width: MediaQuery.of(context).size.width - 30,
            child: loading
                ? SpinKitThreeBounce(
                    itemBuilder: ((context, index) {
                      final colors = [Colors.green, Colors.orange];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    size: w * 0.06,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02))),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);

                      setState(() {
                        loading = false;
                      });
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/BHIM.png'),
                          filterQuality: FilterQuality.low,
                          height: w * 0.05,
                          width: w * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "UPI",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: w * 0.03,
          ),
          //TODO: Add Google Pay
          SizedBox(
            height: w * 0.1,
            width: MediaQuery.of(context).size.width - 30,
            child: gPayLoading
                ? SpinKitThreeBounce(
                    itemBuilder: ((context, index) {
                      final colors = [
                        Colors.blue,
                        Colors.green,
                        Colors.yellow,
                        Colors.red
                      ];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    size: w * 0.06,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02))),
                    onPressed: () async {
                      setState(() {
                        gPayLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);

                      setState(() {
                        gPayLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/Gpay.png'),
                          // fit: BoxFit.contain,
                          height: w * 0.05,
                          width: w * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Google Pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          SizedBox(
            height: w * 0.03,
          ),

          //TODO Add:PhonePay
          SizedBox(
            height: w * 0.1,
            width: MediaQuery.of(context).size.width - 30,
            child: phonePayLoading
                ? SpinKitThreeBounce(
                    itemBuilder: ((context, index) {
                      final colors = [Colors.purple, Colors.white];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    size: w * 0.06,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02))),
                    onPressed: () async {
                      setState(() {
                        phonePayLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);

                      setState(() {
                        phonePayLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/PhonePay.png'),
                          // fit: BoxFit.contain,
                          height: w * 0.05,
                          width: w * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Pe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: w * 0.03,
          ),

          //TODO:Add:Paytm
          SizedBox(
            height: w * 0.1,
            width: MediaQuery.of(context).size.width - 30,
            child: paytmLoading
                ? SpinKitThreeBounce(
                    itemBuilder: ((context, index) {
                      final colors = [Colors.blue, Colors.white];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                    size: w * 0.06,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.02))),
                    onPressed: () async {
                      setState(() {
                        paytmLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com',
                          amount: int.parse(widget.Spot_Price) * 100);

                      setState(() {
                        paytmLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/Paytm.png'),
                          // fit: BoxFit.contain,
                          height: w * 0.05,
                          width: w * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Paytm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  _paymentContainer(double w) {
    return Positioned(
      top: MediaQuery.of(context).size.width * 1,
      left: w * 0.01,
      child: Container(
        // margin: EdgeInsets.fromLTRB(75, 0, 0, 0),
        // padding: EdgeInsets.all(15.0),
        height: w * 0.57,
        width: MediaQuery.of(context).size.width - 10,
        //width: 360,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(w * 0.03)),
      ),
    );
  }

  _couponCode(double w) {
    return Positioned(
      top: MediaQuery.of(context).size.width * 1.57,
      right: -w * 0.002,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          height: w * 0.16,
          width: MediaQuery.of(context).size.width * 0.98,
          child: TextButton(
            onPressed: () {
              print("Coupon Pressed");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(w * 0.03, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Apply Coupon",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w * 0.4,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(w * 0.02, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ">",
                        style: TextStyle(
                            color: Color(0xffD15858),
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
