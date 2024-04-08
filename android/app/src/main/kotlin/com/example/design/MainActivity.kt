package com.example.design



import io.flutter.embedding.android.FlutterActivity
import android.app.Application

import com.yandex.mapkit.MapKitFactory


class MainActivity: FlutterActivity() {
}
class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("en_US") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("c29e3f51-6ad9-47eb-85d2-d90aec454225") // Your generated API key
  }
}