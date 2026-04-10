import Flutter
import UIKit

public class FlutterPluginWynPlugin: NSObject, FlutterPlugin, BatteryHostApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_wyn", binaryMessenger: registrar.messenger())
    let instance = FlutterPluginWynPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      BatteryHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "showToastPlugin":
        result("iOS showToastPlugin \(Int.random(in: 1...100))")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
    func getBatteryLevel() throws -> String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let level = Int(UIDevice.current.batteryLevel * 100)
        
        return "\(level)%"
    }
    
}
