import 'package:ardent_sports/Screen/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Screen/Home/HomePage.dart';

class WebViewLiveMaintainerPreviewFixture extends StatefulWidget {
  final String Tourney_id;
  final String? userId;
  final String SpotNo;
  const WebViewLiveMaintainerPreviewFixture(
      {Key? key,
      required this.Tourney_id,
      required this.userId,
      required this.SpotNo})
      : super(key: key);

  @override
  State<WebViewLiveMaintainerPreviewFixture> createState() =>
      _WebViewLiveMaintainerPreviewFixtureState();
}

class _WebViewLiveMaintainerPreviewFixtureState
    extends State<WebViewLiveMaintainerPreviewFixture> {
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
              'http://ec2-52-66-209-218.ap-south-1.compute.amazonaws.com:3000/getLivFixtures?TOURNAMENT_ID=${widget.Tourney_id}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => _controller = controller,
        ),
      ),
    );
  }
}
