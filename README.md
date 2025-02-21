
# Size SDK

A lightweight Flutter plugin that provides size recommendations based on height and weight measurements using BMI calculations.

## Features

- Size recommendations based on height and weight
- Support for both iOS and Android platforms

## Getting Started

### Installation

Add `size_sdk` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  size_sdk: ^0.0.1
```

### Usage

Import the package:

```dart
import 'package:size_sdk/size_sdk.dart';
```

Create an instance of SizeSdk:

```dart
final sizeSdk = SizeSdk();
```

Calculate size recommendation:

```dart
try {
  final size = await sizeSdk.calculateSize(height: 170, weight: 70);
  print('Recommended size: $size');
} catch (e) {
  print('Error calculating size: $e');
}
```

### Example

You will find a complete example application within `example` folder.


### Size Calculation Logic

The size recommendations are calculated based on BMI ranges:

- S: BMI < 18.5
- M: BMI 18.5-24.9
- L: BMI 25-29.9
- XL: BMI ≥ 30

BMI is calculated using the formula: weight (kg) / (height (m))²

### Testing

Run the tests using:

```sh
flutter test
```