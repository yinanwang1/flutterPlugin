import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_wyn/Message.g.dart';
import 'package:flutter_plugin_wyn/flutter_plugin_wyn.dart';

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
  String _wynMessage = "还没获取";
  String _batteryLevel = '100%';
  final _flutterPluginWynPlugin = FlutterPluginWyn();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    FlutterPluginWyn.initListener();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterPluginWynPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    String batteryLevel = await BatteryHostApi().getBatteryLevel();

    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _fetchWynMessage() async {
    String message;
    try {
      message = await _flutterPluginWynPlugin.showToastPlugin() ?? "没有获取到";
    } on PlatformException {
      message = "获取失败了";
    }

    if (!mounted) return;

    setState(() {
      _wynMessage = message;
    });
  }

  Future<void> _postWynMessage() async {
    String message;
    try {
      await _flutterPluginWynPlugin.postMessage("我是pos wyn message");
    } on PlatformException {
      message = "获取失败了";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(onPressed: _fetchWynMessage, child: Text("调用toast访问")),
              ),
              Padding(padding: EdgeInsets.only(top: 15), child: Text("message is $_wynMessage")),
              Padding(padding: EdgeInsets.only(top: 15), child: Text("batteryLevel is $_batteryLevel")),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(onPressed: initPlatformState, child: Text("主动获取电池信息")),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(onPressed: _postWynMessage, child: Text("向native发信息，并监听")),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
