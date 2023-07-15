// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'desktop_clipboard_platform_interface.dart';
import 'dart:typed_data';

class DesktopClipboard {
  Future<bool?> copyImageByPath(String filePath) {
    return DesktopClipboardPlatform.instance.copyImageByPath(filePath);
  }

  Future<bool?> copyImage(Uint8List image) {
    return DesktopClipboardPlatform.instance.copyImage(image);
  }
}
