
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/Message.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/example/flutter_plugin_wyn/Message.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.example.flutter_plugin_wyn'
  ),
  swiftOut: 'ios/Classes/Messages.g.swift'
))


@HostApi()
abstract class BatteryHostApi {
  String getBatteryLevel();
}