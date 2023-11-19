import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let versionChannel = FlutterMethodChannel(name: "com.example.flutter_dogs/version",
                                                    binaryMessenger: controller.binaryMessenger)

        versionChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "getVersion" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self.getVersion(result: result)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getVersion(result: FlutterResult) {
        let device = UIDevice.current
        result(String(device.systemVersion))
    }
}
