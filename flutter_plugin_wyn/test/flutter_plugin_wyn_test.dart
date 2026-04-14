import 'package:flutter_plugin_wyn/flutter_plugin_wyn.dart';
import 'package:flutter_plugin_wyn/flutter_plugin_wyn_method_channel.dart';
import 'package:flutter_plugin_wyn/flutter_plugin_wyn_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPluginWynPlatform with MockPlatformInterfaceMixin implements FlutterPluginWynPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> showToastPlugin() {
    return Future.value("我就是我");
  }

  @override
  Future<void> postMessage(String message) {
    return Future.value();
  }
}

void main() {
  final FlutterPluginWynPlatform initialPlatform = FlutterPluginWynPlatform.instance;

  test('$MethodChannelFlutterPluginWyn is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPluginWyn>());
  });

  test('getPlatformVersion', () async {
    FlutterPluginWyn flutterPluginWynPlugin = FlutterPluginWyn();
    MockFlutterPluginWynPlatform fakePlatform = MockFlutterPluginWynPlatform();
    FlutterPluginWynPlatform.instance = fakePlatform;

    expect(await flutterPluginWynPlugin.getPlatformVersion(), '42');
  });
}
