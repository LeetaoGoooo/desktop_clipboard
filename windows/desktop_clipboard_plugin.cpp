#include "desktop_clipboard_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace desktop_clipboard {

// static
void DesktopClipboardPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "desktop_clipboard",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<DesktopClipboardPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

DesktopClipboardPlugin::DesktopClipboardPlugin() {}

DesktopClipboardPlugin::~DesktopClipboardPlugin() {}

void DesktopClipboardPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("copyImageByPath") == 0) {
    auto *kwargs = method_call.kwargs();
    auto filePath = std::get<std::string>(kwargs->at(flutter::EncodableValue("filePath")));
    auto success = copyimage(std::wstring(filePath.begin(), filePath.end()).c_str());
    result->Success(flutter::EncodableValue(success));
  } else {
    result->NotImplemented();
  }
}


bool copyimage(const wchar_t* filename)
{
    bool result = false;
    Gdiplus::Bitmap *gdibmp = Gdiplus::Bitmap::FromFile(filename);
    if (gdibmp)
    {
        HBITMAP hbitmap;
        gdibmp->GetHBITMAP(0, &hbitmap);
        if (OpenClipboard(NULL))
        {
            EmptyClipboard();
            DIBSECTION ds;
            if (GetObject(hbitmap, sizeof(DIBSECTION), &ds))
            {
                HDC hdc = GetDC(HWND_DESKTOP);
                //create compatible bitmap (get DDB from DIB)
                HBITMAP hbitmap_ddb = CreateDIBitmap(hdc, &ds.dsBmih, CBM_INIT,
                    ds.dsBm.bmBits, (BITMAPINFO*)&ds.dsBmih, DIB_RGB_COLORS);
                ReleaseDC(HWND_DESKTOP, hdc);
                SetClipboardData(CF_BITMAP, hbitmap_ddb);
                DeleteObject(hbitmap_ddb);
                result = true;
            }
            CloseClipboard();
        }

        //cleanup:
        DeleteObject(hbitmap);  
        delete gdibmp;              
    }
    return result;
}

}  // namespace desktop_clipboard
