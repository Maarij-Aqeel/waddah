package com.capstone.Waddah

import android.content.Intent
import com.xraph.plugin.flutter_unity_widget.OverrideUnityActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.capstone.waddah/unity")
            .setMethodCallHandler { call, result ->
                if (call.method == "launchUnity") {
                    val intent = Intent(this, OverrideUnityActivity::class.java)
                    intent.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
                    intent.putExtra("fullscreen", false)
                    intent.putExtra("flutterActivity", this.javaClass)
                    startActivityForResult(intent, 1)
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}
