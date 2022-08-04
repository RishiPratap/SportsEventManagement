import 'dart:convert';
import 'dart:developer' as developer;
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Payment extends StatefulWidget {
  final String Spot_Price;
  final String Spot_Number;
  final Socket socket;
  final String btnId;
  Payment({
    Key? key,
    required this.Spot_Price,
    required this.Spot_Number,
    required this.socket,
    required this.btnId,
  }) : super(key: key);
  @override
  State<Payment> createState() => _PaymentState();
}

class Tourney_Id {
  late String TOURNAMENT_ID;
  late String btnId;
  Tourney_Id({required this.TOURNAMENT_ID, required this.btnId});
  Map<String, dynamic> toMap() {
    return {"TOURNAMENT_ID": this.TOURNAMENT_ID, "btnId": this.btnId};
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
        merchantCountryCode: 'IN',
      ));

      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful!")),
      );
      final tourneyID =
          Tourney_Id(TOURNAMENT_ID: "123456", btnId: widget.btnId);
      print(widget.btnId);
      final tourneyID1Map = tourneyID.toMap();
      final json_tourneyid = jsonEncode(tourneyID1Map);

      if (jsonResponse['success'] == 'true') {
        widget.socket.emit('confirm-booking', json_tourneyid);
        debugPrint("Tournamnt ID:$json_tourneyid");
      }

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: ticket()));
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
              _header(),
              _transparentImage(),
              _cards(),
              _cc(),
              _text(),
              _paymentContainer(),
              _upiPayments(),
              _couponCode(),
              const Positioned(
                left: 155,
                top: 210,
                child: Text(
                  "PAYMENT",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Positioned(
                left: 155,
                top: 240,
                child: Text(
                  '₹ $amount',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Positioned(
                left: 60,
                top: 400,
                child: Text(
                  "DEBIT CARD",
                  style: TextStyle(
                      color: Color(0xffD15858),
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Positioned(
                right: 50,
                top: 400,
                child: Text(
                  "CREDIT CARD",
                  style: TextStyle(
                      color: Color(0xffD15858),
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Positioned(
                left: 126,
                top: 100,
                child: Text(
                  "Proceed To Pay",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Positioned(
                  left: 24,
                  top: 50,
                  child: TextButton(
                    child: Text(
                      "<",
                      style: TextStyle(
                          fontSize: 30,
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

  _header() {
    return SizedBox(
      height: 250,
      child: Stack(children: [
        _backgroundImage(),
      ]),
    );
  }

  _backgroundImage() {
    return Positioned(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/Rectangle 79.png"))),
      ),
    );
  }

  _transparentImage() {
    return Positioned(
      top: 180,
      left: 5,
      child: Container(
        // margin: EdgeInsets.fromLTRB(75, 0, 0, 0),
        // padding: EdgeInsets.all(15.0),
        height: 280,
        width: MediaQuery.of(context).size.width - 10,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/transparent.png"))),
      ),
    );
  }

  _cards() {
    return Positioned(
      top: 300,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 130,
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/Rectangle 80.png"))),
          ),
          //SizedBox(width: 10),
          Container(
            height: 132,
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/Rectangle 80.png"))),
          ),
        ],
      ),
    );
  }

  _cc() {
    return Positioned(
        top: 305,
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      margin: EdgeInsets.only(right: 25),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                          email: 'example@gmail.com', amount: 20000);
                      developer.log("Afeter Await");
                      setState(() {
                        isCreditLoading = false;
                      });
                    },
                    child: Container(
                      //CREDIT CARD
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/Credit.png"))),
                    ),
                  ),
          ],
        ));
  }

  _text() {
    return Container(
      child: Positioned(
          top: 480,
          right: 200,
          child: Text("Other Payment Modes",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
    );
  }

  _upiPayments() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.6,
      right: 15,
      child: Column(
        children: [
          SizedBox(
            height: 48,
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
                    size: 30.0,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await initPaymentSheet(context,
                          email: 'example@gmail.com', amount: 20000);

                      setState(() {
                        loading = false;
                      });
                    },
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/BHIM.png'),
                          filterQuality: FilterQuality.low,
                          height: 25,
                          width: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "UPI",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          //TODO: Add Google Pay
          SizedBox(
            height: 48,
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
                    size: 30.0,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        gPayLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com', amount: 20000);

                      setState(() {
                        gPayLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/Gpay.png'),
                          // fit: BoxFit.contain,
                          height: 25,
                          width: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Google Pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          const SizedBox(
            height: 12,
          ),

          //TODO Add:PhonePay
          SizedBox(
            height: 48,
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
                    size: 30.0,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        phonePayLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com', amount: 20000);

                      setState(() {
                        phonePayLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/PhonePay.png'),
                          // fit: BoxFit.contain,
                          height: 25,
                          width: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Pe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(
            height: 12,
          ),

          //TODO:Add:Paytm
          SizedBox(
            height: 48,
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
                    size: 30.0,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        paytmLoading = true;
                      });
                      print("Before await");
                      await initPaymentSheet(context,
                          email: 'example@gmail.com', amount: 20000);

                      setState(() {
                        paytmLoading = false;
                      });
                      print("After await");
                    },
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/Paytm.png'),
                          // fit: BoxFit.contain,
                          height: 25,
                          width: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Paytm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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

  _paymentContainer() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.588,
      left: 5,
      child: Container(
        // margin: EdgeInsets.fromLTRB(75, 0, 0, 0),
        // padding: EdgeInsets.all(15.0),
        height: 250,
        width: MediaQuery.of(context).size.width - 10,
        //width: 360,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  _couponCode() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.88,
      right: -2,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.98,
          child: TextButton(
            onPressed: () {
              print("Coupon Pressed");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Apply Coupon",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ">",
                        style: TextStyle(
                            color: Color(0xffD15858),
                            fontSize: 30,
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

  _couponCode2() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.98,
      right: -2,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.98,
          child: TextButton(
            onPressed: () {
              print("Coupon Pressed");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Apply Coupon",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ">",
                        style: TextStyle(
                            color: Color(0xffD15858),
                            fontSize: 30,
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
