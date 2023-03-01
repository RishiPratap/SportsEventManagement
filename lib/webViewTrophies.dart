import 'package:ardent_sports/Screen/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Screen/Home/HomePage.dart';

class WebViewTrophie extends StatefulWidget {
  final String? userId;

  const WebViewTrophie({Key? key, required this.userId}) : super(key: key);

  @override
  State<WebViewTrophie> createState() => _WebViewTrophieState();
}

class _WebViewTrophieState extends State<WebViewTrophie> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trophies'),
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
            'http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/trophy?USERID=${widget.userId}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
