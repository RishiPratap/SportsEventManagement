import 'dart:convert';
import 'package:ardent_sports/Screen/Home/home_page_model.dart';
import 'package:ardent_sports/Screen/Home/widget/get_tournaments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../Helper/apis.dart';

class HomeProvider extends ChangeNotifier {
  // for version of android and ios
  String? androidVersion = '1.0.0';
  String? iOSVersion = '1.0.0';
  List<Card> AllTournaments = [];

  getAllTournaments(BuildContext context) async {
    var response = await get(
      baseTournamentsApi,
    );
    List<dynamic> jsonData = jsonDecode(response.body);
    try {
      List<UserData> userdata =
          jsonData.map((dynamic item) => UserData.fromJson(item)).toList();
      int array_length = userdata.length;
      print(userdata);
      return getTournaments(userdata, array_length, context);
    } catch (e) {
      print(e);
    }
  }
}
