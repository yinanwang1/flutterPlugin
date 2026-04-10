import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_wyn_platform_interface.dart';

/// An implementation of [FlutterPluginWynPlatform] that uses method channels.
class MethodChannelFlutterPluginWyn extends FlutterPluginWynPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_plugin_wyn');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<String?> showToastPlugin() async {
    final message = await methodChannel.invokeMethod<String>(
      'showToastPlugin',
    );
    return message;
  }
}
