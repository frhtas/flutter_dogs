package com.example.flutter_dogs

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Build.VERSION

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter_dogs/version"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getVersion") {
                val version = getVersion()
                result.success(version)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getVersion(): String {
        return VERSION.RELEASE.toString()
    }
}