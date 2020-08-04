import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_user_consent_api/otp_text_edit_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OTPTextEditController controller;
  final scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = OTPTextEditController(
      codeLength: 5,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
    )..startListen(
        (code) => code?.split(' ')?.last ?? '',
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await controller.stopListen();
    super.dispose();
  }
}
