import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CallApi {
  final String _url = 'https://ardentsportsapis.herokuapp.com/';
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }
}

_setHeaders() =>
    {'Content-type': 'application/json', 'Accept': 'application/json'};
