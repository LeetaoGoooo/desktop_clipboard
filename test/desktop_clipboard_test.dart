import 'package:flutter_test/flutter_test.dart';
import 'package:desktop_clipboard/desktop_clipboard.dart';
import 'package:desktop_clipboard/desktop_clipboard_platform_interface.dart';
import 'package:desktop_clipboard/desktop_clipboard_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDesktopClipboardPlatform
    with MockPlatformInterfaceMixin
    implements DesktopClipboardPlatform {
  @override
  Future<bool?> copyImage(String filePath) {
    // TODO: implement copyImage
    throw UnimplementedError();
  }
}

void main() {
  final DesktopClipboardPlatform initialPlatform = DesktopClipboardPlatform.instance;

  test('$MethodChannelDesktopClipboard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDesktopClipboard>());
  });

}
