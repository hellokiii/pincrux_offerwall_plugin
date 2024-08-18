import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pincrux_offerwall_plugin/pincrux_offerwall_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _pincruxOfferwallPlugin = PincruxOfferwallPlugin();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              String pincruxPupKey = Platform.isIOS
                  ? '911775'
                  : '911774';
              print('dddd');
              PincruxOfferwallPlugin.init(pincruxPupKey, '0');
              PincruxOfferwallPlugin.startPincruxOfferwall();
            },
            child: Container(
              alignment: Alignment.center,
                width: 100, height: 100,
                color: Colors.blue,
                child: Text('gogo1')
            ),
          ),
        ),
      ),
    );
  }
}
