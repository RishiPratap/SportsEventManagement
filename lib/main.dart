import 'package:ardent_sports/HomePage.dart';
import 'package:ardent_sports/VerifyPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'LiveMaintainer.dart';
import 'login.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        builder: EasyLoading.init(),
        title: 'Ardent Sports',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => login(),
          '/homePage': (context) => HomePage(),
        },
      );
}
