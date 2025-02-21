import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:size_sdk/size_sdk.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SizeSdk sizeSdk;
  const channel = MethodChannel('size_sdk');

  setUp(() {
    sizeSdk = SizeSdk();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'calculateSize') {
          final height = methodCall.arguments['height'] as double;
          final weight = methodCall.arguments['weight'] as double;
          
          if (height <= 0 || weight <= 0) {
            throw PlatformException(
              code: 'INVALID_ARGUMENTS',
              message: 'Height and weight must be positive numbers',
            );
          }

          final bmi = weight / (height / 100) / (height / 100);
          
          if (bmi < 18.5) return 'S';
          if (bmi < 24.9) return 'M';
          if (bmi < 29.9) return 'L';
          return 'XL';
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('Size Calculator Tests', () {
    test('BMI < 18.5 should return size S', () async {
      final size = await sizeSdk.calculateSize(170, 50);
      expect(size, 'S');
    });

    test('BMI between 18.5 and 24.9 should return size M', () async {
      final size = await sizeSdk.calculateSize(170, 65);
      expect(size, 'M');
    });

    test('BMI between 25 and 29.9 should return size L', () async {
      final size = await sizeSdk.calculateSize(170, 80);
      expect(size, 'L');
    });

    test('BMI >= 30 should return size XL', () async {
      final size = await sizeSdk.calculateSize(170, 90);
      expect(size, 'XL');
    });

    test('Invalid height should throw PlatformException', () {
      expect(
        () => sizeSdk.calculateSize(-170, 70),
        throwsA(isA<PlatformException>()),
      );
    });

    test('Invalid weight should throw PlatformException', () {
      expect(
        () => sizeSdk.calculateSize(170, -70),
        throwsA(isA<PlatformException>()),
      );
    });
  });
}
