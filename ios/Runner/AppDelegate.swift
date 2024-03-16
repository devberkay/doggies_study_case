import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.example.dogAppnation"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("Doggnation could not find FlutterViewController")
    }
    let osVersionChannel = FlutterMethodChannel(name: channelName,
                                                binaryMessenger: controller.binaryMessenger)
    osVersionChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is called on the UI thread.
      guard call.method == "getOSVersion" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.receiveGetOSVersion(call: call, result: result)
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveGetOSVersion(call: FlutterMethodCall, result: FlutterResult) {
    let osVersion = UIDevice.current.systemVersion
    result(osVersion)
  }

}
