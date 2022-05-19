import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
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
              // _test(),
              // _otherPaymentMode(),
              //_otherText(),
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
              const Positioned(
                left: 155,
                top: 240,
                child: Text(
                  "₹ 499",
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
                      SystemNavigator.pop();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return Container(
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
        //width: 360,
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
              height: 130,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/Rectangle 80.png"))),
            ),
          ],
        ));
  }

  _cc() {
    return Positioned(
        top: 305,
        left: 0,
        right: 0,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: () async {
                await makePayment();
              },
              child: Container(
                //CREDIT_CARD
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                margin: EdgeInsets.only(right: 25),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/Credit.png"))),
              ),
            ),
            // Spacer(),
            //SizedBox(width: 10),
            FlatButton(
              onPressed: () async {
                await makePayment();
              },
              child: Container(
                //DEBITCARD
                // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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

  _testpaymentContainer() {
    return Positioned(
      top: 510,
      left: 5,
      child: Container(
        // margin: EdgeInsets.fromLTRB(75, 0, 0, 0),
        // padding: EdgeInsets.all(15.0),
        height: 280,
        width: MediaQuery.of(context).size.width - 10,
        //width: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/paymentTransparent.png"))),
      ),
    );
  }

  _otherPaymentMode() {
    return Positioned(
      top: 520,
      right: 15,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 30,
            height: 53,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: AssetImage("assets/Rectangle 83.png"))),
            // child: TextField(
            //   decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.black,
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //           borderSide: BorderSide(color: Colors.black))),
            // ),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.0),
            //     image: DecorationImage(
            //       image: AssetImage("assets/Rectangle 83.png"),
            //     )
            //     ),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 53,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: AssetImage("assets/Rectangle 83.png"))),
            ),
          ),
          Positioned(
            top: 140,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 53,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: AssetImage("assets/Rectangle 83.png"))),
            ),
          ),
          Positioned(
            top: 210,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 53,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      fit: BoxFit.cover,
                      image: AssetImage("assets/Rectangle 83.png"))),
            ),
          ),
        ],
      ),
    );
  }

  _otherText() {
    return Stack(
      children: [
        Container(
          child: Positioned(
              top: 530,
              left: 60,
              child: Text("UPI",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        Container(
          child: Positioned(
              top: 605,
              left: 60,
              child: Text("Google Pay",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        Container(
          child: Positioned(
              top: 675,
              left: 60,
              child: Text("Phone Pe",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        Container(
          child: Positioned(
              top: 745,
              left: 60,
              child: Text("Paytm",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
      ],
    );
  }

  _test() {
    return Positioned(
      top: 520,
      right: 15,
      child: Stack(clipBehavior: Clip.none, children: [
        SizedBox(
          height: 43,
          width: MediaQuery.of(context).size.width - 30,
          child: FlatButton(
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
            onPressed: () {
              print("PRessed");
            },
          ),
        ),
        Positioned(
          top: 60,
          child: SizedBox(
            height: 43,
            width: MediaQuery.of(context).size.width - 30,
            child: TextButton(
              onPressed: () {
                print("PRessed");
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
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
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: SizedBox(
            height: 43,
            width: MediaQuery.of(context).size.width - 30,
            child: FlatButton(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
              onPressed: () {
                print("PRessed");
              },
            ),
          ),
        ),
        Positioned(
          top: 180,
          child: SizedBox(
            height: 43,
            width: MediaQuery.of(context).size.width - 30,
            child: FlatButton(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
              onPressed: () {
                print("PRessed");
              },
            ),
          ),
        ),
      ]),
    );
  }

  _upiPayments() {
    return Positioned(
      top: 520,
      right: 15,
      child: Column(
        children: [
          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width - 30,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                await makePayment();
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
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                print("Pressed");
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
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                print("Pressed");
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
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                print("Pressed");
              },
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('assets/Paytm.png'),
                    // fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                  ),
                  const Padding(
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
      top: 510,
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
      top: 760,
      right: -2,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          height: 80,
          width: 400,
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
                  const Padding(
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

  var stripeApiKey =
      "sk_test_51Kx9oUSDyPLJYmvrHGifQoOVMJTLzveCWgOMKSdYGUKOhgqEW5pDoA9XTbs5NDki9XW4mmU4wNna8uFdpoM0BanG00uedfdbjt";

  var amount = '300';

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('$amount', 'INR');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        applePay: true,
        googlePay: true,
        style: ThemeMode.system,
        merchantCountryCode: 'IN',
        merchantDisplayName: 'Malhar',
      ));

      displayPaymentSheet();
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true));

      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment Successful...')));
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripeApiKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body.toString());
    } catch (e) {
      print('exception' + e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}
