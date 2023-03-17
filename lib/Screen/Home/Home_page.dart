// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';
import '../../Helper/apis.dart';
import '../menu/menu.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../Model/user_model.dart';
import '../../Profile.dart';
import '../Authentication/updateDialog.dart';
import 'home_page_provider.dart';

HomeProvider? homePagedProvider;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime timeBackPressed = DateTime.now();

  void userData() async {
    try {
      var response = await get(
        baseTournamentsApi,
      );
      List<dynamic> jsonData = jsonDecode(response.body);

      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
    } catch (err) {}
  }

  update() {
    setState(() {});
  }

  var futures;
  @override
  void initState() {
    super.initState();
    homePagedProvider = Provider.of<HomeProvider>(context, listen: false);
    homePagedProvider!.initializeVariables();
    showUpdateDialog();
    futures = homePagedProvider!.getAllTournaments(context);
    homePagedProvider!.getDetails(update);
    // userData();
  }

  showUpdateDialog() async {
    homePagedProvider!.getVersions().then(
      (value) async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String version = packageInfo.version;

        final Version currentVersion = Version.parse(version);
        final Version latestVersionAnd =
            Version.parse(homePagedProvider!.androidVersion!);
        final Version latestVersionIos =
            Version.parse(homePagedProvider!.iOSVersion!);

        if ((Platform.isAndroid && latestVersionAnd > currentVersion) ||
            (Platform.isIOS && latestVersionIos > currentVersion)) {
          showAppUpdateDialog(context);
        }
      },
    );
    setState(() {});
  }

  Future<void> _refreshTournaments() async {
    // homePagedProvider!.mapUserInfo!.clear();
    Navigator.pushReplacement(
        context, PageRouteBuilder(pageBuilder: (a, b, c) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double progress = double.parse(
      homePagedProvider!.mapUserInfo?['Points'] ?? '0',
    );
    String Level = homePagedProvider!.mapUserInfo?['Level'] ?? '0';

    String totalPoints = homePagedProvider!.mapUserInfo?['TotalPoints'] ?? '0';

    Widget buildLinearProgressIndicator() => Text(
          '${(progress * 100).toStringAsFixed(0)}/$totalPoints',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        );
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          onRefresh: () => _refreshTournaments(),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Homepage.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: deviceWidth * 0.2,
                              height: deviceHeight * 0.07,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/AARDENT_LOGO.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.2,
                              height: deviceHeight * 0.08,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/Ardent_Sport_Text.png"),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => Menu(
                                  name: homePagedProvider!.mapUserInfo?['Name'],
                                ));
                          },
                          child: Container(
                            width: deviceWidth * 0.1,
                            height: deviceHeight * 0.02,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/menu_bar.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              Profile(
                                name: homePagedProvider!.mapUserInfo?['Name'],
                                email: homePagedProvider!.email,
                                level: homePagedProvider!.mapUserInfo?['Level'],
                                pointsScored: homePagedProvider!
                                    .mapUserInfo?['PointsScored'],
                                points:
                                    homePagedProvider!.mapUserInfo?['Points'],
                                totalPoints: homePagedProvider!
                                    .mapUserInfo?['TotalPoints'],
                                totalTourney: homePagedProvider!
                                    .mapUserInfo?['TOTAL_TOURNAMENTS'],
                                tourneyWon:
                                    homePagedProvider!.mapUserInfo?['TROPHIES'],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: deviceWidth * 0.10,
                                height: deviceHeight * 0.05,
                                margin:
                                    EdgeInsets.only(left: deviceWidth * 0.02),
                                padding:
                                    EdgeInsets.only(left: deviceWidth * 0.02),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/Profile_Image.png"),
                                        fit: BoxFit.fitHeight)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: deviceWidth * 0.02,
                                ),
                                child: Text(
                                    "${homePagedProvider!.mapUserInfo == null ? "Loading.." : homePagedProvider!.mapUserInfo?['Name']}"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.09,
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: deviceWidth * 0.028),
                              child: Text(
                                "Level :$Level",
                                style: GoogleFonts.hennyPenny(fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor:
                                          Color.fromARGB(255, 55, 54, 54),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    ),
                                  ),
                                  Center(child: buildLinearProgressIndicator())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    FutureBuilder(
                      future: futures,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: snapshot.data,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
