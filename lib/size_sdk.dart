import 'package:size_sdk_platform_interface/size_sdk_platform_interface.dart';

class SizeSdk {
  Future<String> calculateSize(double height, double weight) {
    return SizeSdkPlatform.instance.calculateSize(height, weight);
  }
}
