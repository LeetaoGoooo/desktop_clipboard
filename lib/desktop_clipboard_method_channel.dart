import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import 'desktop_clipboard_platform_interface.dart';

/// An implementation of [DesktopClipboardPlatform] that uses method channels.
class MethodChannelDesktopClipboard extends DesktopClipboardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('desktop_clipboard');

  @override
  Future<bool?> copyImageByPath(String filePath) async {
    try {
      final res =  await methodChannel.invokeMethod<bool>('copyImageByPath', {
        "filePath":filePath
      });
      return res;
    } catch (e) {
      developer.log("copyImageByPath: ${e.toString()}",name: "DesktopClipboard");
    }
    return false;
  }

  @override
  Future<bool?> copyImage(Uint8List image) async {
    try {
      final res =  await methodChannel.invokeMethod<bool>('copyImage', {
        "image":image
      });
      return res;
    } catch (e) {
      developer.log("copyImage: ${e.toString()}",name: "DesktopClipboard");
    }
    return false;
  }
}
