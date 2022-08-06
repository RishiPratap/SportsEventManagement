import 'package:ardent_sports/BadmintonSpotSelection.dart';
import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/HostedChallenges.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'CreateChallenge.dart';
import 'login.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      Stripe.publishableKey =
          'pk_test_51Kx9oUSDyPLJYmvrp5H6rmxyMHQHAHVF38RnAiJzzWI2euD0orPuqf9SOJGpNcAf6FHLYfIOCbihzJR4lBcPrgTw00PKpqaeoy',
      await Stripe.instance.applySettings(),
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      )),
      runApp(MyApp())
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ardent Sports',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => login(),
        '/homePage': (context) => HomePage(),
      },
    );
  }
}
