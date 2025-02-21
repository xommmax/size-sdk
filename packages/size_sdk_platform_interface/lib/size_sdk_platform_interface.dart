import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_size_sdk.dart';

abstract class SizeSdkPlatform extends PlatformInterface {
  SizeSdkPlatform() : super(token: _token);

  static final Object _token = Object();
  static SizeSdkPlatform _instance = MethodChannelSizeSdk();

  static SizeSdkPlatform get instance => _instance;

  static set instance(SizeSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> calculateSize(double height, double weight) {
    throw UnimplementedError('calculateSize() has not been implemented.');
  }
}
