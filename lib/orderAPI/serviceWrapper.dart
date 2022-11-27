import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class servicewrapper {
  call_order_api(String amount) async {
    dynamic jsonresponse = "[]";
    var url = 'https://ardent-api.onrender.com/rzp_payment';
    final body = {'amount': amount};

    // without header
    final response = await http.post(Uri.parse(url), body: body);

    print(" get response done " + response.body.toString());
    try {
      jsonresponse = json.decode(response.body.toString());
    } catch (error) {
      print(" get-categrrory error " + error.toString());
    }
    return jsonresponse;
  }
}
