package com.example.flutter_plugin_wyn

import android.content.Context
import android.os.BatteryManager
import android.os.Looper
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Runnable
import kotlinx.coroutines.launch
import java.util.logging.Handler
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

    private lateinit var basicChannel: BasicMessageChannel<Any>

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin_wyn")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
        BatteryHostApi.setUp(flutterPluginBinding.binaryMessenger, this)

        random = Random(1)

        basicChannel = BasicMessageChannel(flutterPluginBinding.binaryMessenger, "my_basic_channel",
            StandardMessageCodec())
        basicChannel.setMessageHandler { message, reply ->
            Log.d("wyn", "wyn 收到flutter的message is $message")
            reply.reply("Android 收到了 ${Thread.currentThread().name}")
        }
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

        sendToFlutter()

        return "wyn level $level%"
    }

    fun sendToFlutter() {
        val thread = Thread(Runnable(){
            Log.d("wyn", "wyn thread ${Thread.currentThread().name}")

            var total = 0L
            for (i in 1..1000) {
                total = total + i
            }

            Log.d("wyn", "wyn total is $total")

            CoroutineScope(Dispatchers.Main).launch {
                basicChannel.send("Hello from Android wyn total is $total  thread is ${Thread.currentThread().name}")
            }
        })
        thread.start()
    }
}
