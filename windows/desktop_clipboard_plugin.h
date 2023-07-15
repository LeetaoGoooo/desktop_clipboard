#ifndef FLUTTER_PLUGIN_DESKTOP_CLIPBOARD_PLUGIN_H_
#define FLUTTER_PLUGIN_DESKTOP_CLIPBOARD_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace desktop_clipboard {

class DesktopClipboardPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DesktopClipboardPlugin();

  virtual ~DesktopClipboardPlugin();

  // Disallow copy and assign.
  DesktopClipboardPlugin(const DesktopClipboardPlugin&) = delete;
  DesktopClipboardPlugin& operator=(const DesktopClipboardPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace desktop_clipboard

#endif  // FLUTTER_PLUGIN_DESKTOP_CLIPBOARD_PLUGIN_H_
