
import 'package:flutter_plugin_wyn/Message.g.dart';

import 'flutter_plugin_wyn_platform_interface.dart';

class FlutterPluginWyn {
  static final BatteryHostApi _api = BatteryHostApi();
  static Future<String> getBatteryLevel() {
    return _api.getBatteryLevel();
  }

  Future<String?> getPlatformVersion() {
    return FlutterPluginWynPlatform.instance.getPlatformVersion();
  }

  Future<String?> showToastPlugin() {
    return FlutterPluginWynPlatform.instance.showToastPlugin();
  }
}
