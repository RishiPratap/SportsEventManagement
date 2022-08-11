import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  final String? spots;
  const WebViewTest({Key? key, required this.spots}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixtures'),
      ),
      body: WebView(
        initialUrl:
            'https://ardentsportsapis.herokuapp.com/?no_of_spots=${widget.spots}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
