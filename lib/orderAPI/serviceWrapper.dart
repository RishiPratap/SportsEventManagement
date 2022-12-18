import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class servicewrapper {
  call_order_api(String amount) async {
    dynamic jsonresponse = "[]";
    var url =
        'http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/rzp_payment';
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
