import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'dart:typed_data';
import 'desktop_clipboard_method_channel.dart';

abstract class DesktopClipboardPlatform extends PlatformInterface {
  /// Constructs a DesktopClipboardPlatform.
  DesktopClipboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static DesktopClipboardPlatform _instance = MethodChannelDesktopClipboard();

  /// The default instance of [DesktopClipboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelDesktopClipboard].
  static DesktopClipboardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DesktopClipboardPlatform] when
  /// they register themselves.
  static set instance(DesktopClipboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> copyImageByPath(String filePath) async{
    throw UnimplementedError('copyImageByPath() has not been implemented.');
  }

  Future<bool?> copyImage(Uint8List image) async {
    throw UnimplementedError('copyImage() has not been implemented.');
  }
}
