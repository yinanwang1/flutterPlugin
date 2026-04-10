package com.example.flutter_plugin_wyn

import android.content.Context
import android.os.BatteryManager
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.random.Random

/** FlutterPluginWynPlugin */
class FlutterPluginWynPlugin :
    FlutterPlugin,
    MethodCallHandler,
    BatteryHostApi {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var random: Random

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin_wyn")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
        BatteryHostApi.setUp(flutterPluginBinding.binaryMessenger, this)

        random = Random(1)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "showToastPlugin") {
            Toast.makeText(context, "123", Toast.LENGTH_LONG).show()

            result.success("android ${random.nextInt()}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)

        BatteryHostApi.setUp(binding.binaryMessenger, null)
    }

    override fun getBatteryLevel(): String {
        val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        val level = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

        return "wyn level $level%"
    }
}
