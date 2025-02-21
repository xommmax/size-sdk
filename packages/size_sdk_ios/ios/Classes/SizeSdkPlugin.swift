import Flutter
import UIKit

public class SizeSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "size_sdk", binaryMessenger: registrar.messenger())
        let instance = SizeSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "calculateSize" {
            guard let args = call.arguments as? [String: Any],
                  let height = args["height"] as? Double,
                  let weight = args["weight"] as? Double else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                  message: "Height and weight are required",
                                  details: nil))
                return
            }
            
            let bmi = weight / pow(height / 100, 2)
            
            let size: String
            switch bmi {
            case ..<18.5:
                size = "S"
            case 18.5..<24.9:
                size = "M" 
            case 24.9..<29.9:
                size = "L"
            default:
                size = "XL"
            }
            
            result(size)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
