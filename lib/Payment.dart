import 'dart:convert';
import 'dart:developer' as developer;
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
      body: Container(
        height: h,
        child: Stack(
          children: [
            _header(),
            _transparentImage(),
            _cards(),
            _cc(),
            _text(),
            _paymentContainer(),
            Positioned(
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
                "₹ 499",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Positioned(
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
            Positioned(
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
            Positioned(
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
              child: Text(
                "<",
                style: TextStyle(
                    fontSize: 35,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Positioned(
              left: 24,
              top: 50,
              child: Text(
                "<",
                style: TextStyle(
                    fontSize: 35,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
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

  _paymentContainer() {
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
        merchantCountryCode: 'US',
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
