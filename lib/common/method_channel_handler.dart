import 'dart:developer';

import 'package:flutter/services.dart';

import '../features/settings/bloc/settings_bloc.dart';

class MethodChannelHandler {
  final SettingsBloc settingsBloc;
  static const String _channelName = 'com.example.flutter_dogs/version';
  static const MethodChannel _channel = MethodChannel(_channelName);

  MethodChannelHandler({required this.settingsBloc}) {
    getVersion();
  }

  // Handle the call from native code to get the version
  Future getVersion() async {
    try {
      final String version = await _channel.invokeMethod('getVersion');
      settingsBloc.add(LoadSettings(version: version));
    } on PlatformException catch (e) {
      log("PlatformException: ${e.message}");
    }
  }
}
