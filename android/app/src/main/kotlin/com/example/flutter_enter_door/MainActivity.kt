package com.example.flutter_enter_door

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private var sharedText: String? = "MainActivity's Empty Text"

    companion object {
        private const val TAG = "MainActivity"
        private const val CHANNEL = "app.channel.shared.data"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 处理外部应用的intent
        val action = intent.action
        val type = intent.type
        Log.d(TAG, "onCreate: $action $type")
        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/plain" == type) {
                handleSendText(intent); // Handle text being sent
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        Log.d(TAG, "configureFlutterEngine: ")
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            Log.d(TAG, "onMethodCall: ")
            if (call.method.contentEquals("getSharedText")) {
                Log.d(TAG, "onMethodCall: getSharedText $sharedText")
                result.success(sharedText)
                sharedText = null
            }
        }
    }

    private fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
        Log.d(TAG, "handleSendText sharedText: $sharedText")
    }

}
