import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePage.dart';

class WebViewSpots extends StatefulWidget {
  final String? spots;

  const WebViewSpots({Key? key, required this.spots}) : super(key: key);

  @override
  State<WebViewSpots> createState() => _WebViewSpotsState();
}

class _WebViewSpotsState extends State<WebViewSpots> {
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
            'https://ardentsportsapis.herokuapp.com/?no_of_spots=${widget.spots}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
