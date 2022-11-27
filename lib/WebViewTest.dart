import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePage.dart';

class WebViewTest extends StatefulWidget {
  final String Tourney_id;
  final String? userId;
  const WebViewTest({Key? key, required this.Tourney_id, required this.userId})
      : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Fixtures'),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      PageRouteBuilder(pageBuilder: (a, b, c) => HomePage()));
                },
                icon: const Icon(Icons.home)),
          ],
        ),
        body: WebView(
          initialUrl:
              'https://ardent-api.onrender.com/getBookingFixtures?TOURNAMENT_ID=${widget.Tourney_id}&USERID=${widget.userId}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => _controller = controller,
        ),
      ),
    );
  }
}
