import Cocoa
import FlutterMacOS

public class DesktopClipboardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "desktop_clipboard", binaryMessenger: registrar.messenger)
    let instance = DesktopClipboardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "copyImageByPath":
        let arguments = call.arguments as! Dictionary<String,Any>
        let fileURL = URL(fileURLWithPath:  arguments["filePath"] as! String)
        let image = NSImage(contentsOf:fileURL)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        let success = pasteboard.writeObjects([image!])
      result(success)
    case "copyImage":
        let arguments = call.arguments as! Dictionary<String,Any>
        let uInt8List = arguments["image"] as! FlutterStandardTypedData
        let bytes = [UInt8](uInt8List.data)
        let data = Data(bytes:bytes, count: bytes.count)
        let image = NSImage(data:data)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        let success = pasteboard.writeObjects([image!])
      result(success)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
