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
    MapKitFactory.setApiKey("04364003-6929-4113-b557-99bc856dcfb3") // Your generated API key
  }
}