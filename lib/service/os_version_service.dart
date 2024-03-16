import 'dart:io';
import 'package:flutter/services.dart';

class OsVersionService {
  static final OsVersionService _instance = OsVersionService._internal();
  static final _platform = MethodChannel(Platform.isIOS ? 'com.example.dogAppnation' : 'com.example.dog_appnation');

  String _osVersion = "";

  // Private constructor
  OsVersionService._internal();

  // Factory constructor
  factory OsVersionService() {
    return _instance;
  }

  // Getter for osVersion
  String get osVersion => _osVersion;

  // Method to asynchronously read the OS version and set _osVersion
  Future<void> readVersion() async {
    try {
      final String result = await _platform.invokeMethod('getOSVersion');
      _instance._osVersion = result;
    } on PlatformException catch (e) {
      _instance._osVersion = "Failed to get OS version: '${e.message}'.";
    }
  }
}
