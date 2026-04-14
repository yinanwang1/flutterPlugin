
import 'package:flutter/services.dart';
import 'package:flutter_plugin_wyn/Message.g.dart';

import 'flutter_plugin_wyn_platform_interface.dart';

class FlutterPluginWyn {
  static final BatteryHostApi _api = BatteryHostApi();

  static const _channel = BasicMessageChannel('my_basic_channel', StandardMessageCodec());


  static Future<String> getBatteryLevel() {
    return _api.getBatteryLevel();
  }

  Future<String?> getPlatformVersion() {
    return FlutterPluginWynPlatform.instance.getPlatformVersion();
  }

  Future<String?> showToastPlugin() {
    return FlutterPluginWynPlatform.instance.showToastPlugin();
  }

  Future<void> postMessage(String message) async {
    final reply = await _channel.send({
      "type": "greet",
      "msg": message
    });

    print("Native 回复:$reply");
  }

  static void initListener() {
    _channel.setMessageHandler((message) async {
      print("收到 Native 消息： $message");

      return "Flutter 收到了";
    });
  }
}
