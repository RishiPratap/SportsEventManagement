import 'package:ardent_sports/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'HomePage.dart';

class WebViewTournamentDetails extends StatefulWidget {
  final String? Tournament_Id;

  const WebViewTournamentDetails({Key? key, required this.Tournament_Id})
      : super(key: key);

  @override
  State<WebViewTournamentDetails> createState() =>
      _WebViewTournamentDetailsState();
}

class _WebViewTournamentDetailsState extends State<WebViewTournamentDetails> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
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
            'https://ardent-api.onrender.com/hosted?TOURNAMENT_ID=${widget.Tournament_Id}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
