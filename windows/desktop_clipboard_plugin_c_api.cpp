#include "include/desktop_clipboard/desktop_clipboard_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "desktop_clipboard_plugin.h"

void DesktopClipboardPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  desktop_clipboard::DesktopClipboardPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
