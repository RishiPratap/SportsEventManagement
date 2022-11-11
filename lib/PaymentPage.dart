import 'dart:convert';
import 'package:ardent_sports/HomePage.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:ardent_sports/ticket.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String? userId;
  final String tourneyId;
  final String? tourneyName;
  final String? entryFee;
  final String? sportName;
  final String? location;
  final String date;
  final String spotNo;
  final String category;
  final Socket socket;

  const PaymentPage({
    Key? key,
    required this.userId,
    required this.tourneyId,
    required this.tourneyName,
    required this.entryFee,
    required this.sportName,
    required this.location,
    required this.date,
    required this.spotNo,
    required this.category,
    required this.socket,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class Tourney_Id {
  late String tourneyId;
  late String spotNo;
  String? userId;
  Tourney_Id(
      {required this.tourneyId, required this.spotNo, required this.userId});
  Map<String, dynamic> toMap() {
    return {
      "TOURNAMENT_ID": this.tourneyId,
      "btnId": this.spotNo,
      "USERID": this.userId
    };
  }
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    print('Tournament ID ${widget.tourneyId}');
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Payment'),
        ),
        body: WebView(
          initialUrl:
              'https://ardentsportsapis.herokuapp.com/paymentPage?username=${widget.userId}&tournament_name=${widget.tourneyName}&tournament_id=${widget.tourneyId}&price=${widget.entryFee}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => _controller = controller,
          onPageFinished: (url) {
            if (url.contains('success')) {
              final tourneyId = Tourney_Id(
                  tourneyId: widget.tourneyId,
                  spotNo: widget.spotNo,
                  userId: widget.userId);
              widget.socket
                  .emit('confirm-booking', jsonEncode(tourneyId.toMap()));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ticket(
                    eventName: widget.tourneyName,
                    name: widget.userId,
                    spotNo: widget.spotNo,
                    date: widget.date,
                    location: widget.location,
                    sportName: widget.sportName,
                    category: widget.category,
                  ),
                ),
              );
            } else {
              AlertDialog(
                title: const Text('Payment Failed'),
                content: const Text('Please try again'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
