import 'package:flutter/services.dart';
import 'size_sdk_platform_interface.dart';

class MethodChannelSizeSdk extends SizeSdkPlatform {
  final MethodChannel _channel = const MethodChannel('size_sdk');

  @override
  Future<String> calculateSize(double height, double weight) async {
    final Map<String, dynamic> args = {
      'height': height,
      'weight': weight,
    };
    
    final String size = await _channel.invokeMethod('calculateSize', args);
    return size;
  }
}
