import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePage.dart';

class WebViewTest extends StatefulWidget {
  final String? spots;
  final String Tourney_id;
  const WebViewTest({Key? key, required this.spots, required this.Tourney_id})
      : super(key: key);

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
            'https://ardentsportsapis.herokuapp.com/getTournamentFixtures?TOURNAMENT_ID=${widget.Tourney_id}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
