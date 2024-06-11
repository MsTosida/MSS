import 'package:flutter/services.dart';

class HashFunctionService {
  static const String serviceName = 'com.belstu/hashfunction';
  static const platform = MethodChannel(serviceName);

  static Future<Uint8List> getData() async {
    final Uint8List data = await platform.invokeMethod('getData');
    return data;
  }

  static Future<String> getString() async {
    final String data = await platform.invokeMethod('getString');
    return data;
  }
}
