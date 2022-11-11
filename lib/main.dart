import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/ScoreAChallenge.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'LiveMaintainer.dart';
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
      builder: EasyLoading.init(),
      title: 'Ardent Sports',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // home: login(),
      routes: {
        '/': (context) => login(),
        '/homePage': (context) => HomePage(),
        '/live': (context) => LiveMaintainer(
            Tournament_ID: '',
            Match_Id: '',
            Player_1_name: '',
            Player_2_name: ''),
        // '/scoreChallenge': (context) => ScoreAChallenge()
      },
    );
  }
}
