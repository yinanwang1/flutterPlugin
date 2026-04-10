import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_plugin_wyn_method_channel.dart';

abstract class FlutterPluginWynPlatform extends PlatformInterface {
  /// Constructs a FlutterPluginWynPlatform.
  FlutterPluginWynPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPluginWynPlatform _instance = MethodChannelFlutterPluginWyn();

  /// The default instance of [FlutterPluginWynPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPluginWyn].
  static FlutterPluginWynPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPluginWynPlatform] when
  /// they register themselves.
  static set instance(FlutterPluginWynPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> showToastPlugin() {
    throw UnimplementedError('showToastPlugin() has not been implemented.');
  }
}
