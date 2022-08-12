import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePage.dart';

class WebViewTest extends StatefulWidget {
  final String? spots;
  const WebViewTest({Key? key, required this.spots}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixtures'),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    PageRouteBuilder(pageBuilder: (a, b, c) => HomePage()));
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: WebView(
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              name: 'Print',
              onMessageReceived: (JavascriptMessage message) {
                print(message.message);
              }),
        ].toSet(),
        initialUrl:
            'https://ardentsportsapis.herokuapp.com/getScore?TOURNAMENT_ID=TTbuddhiman3@gmail.com3&MATCHID=Match%204',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
