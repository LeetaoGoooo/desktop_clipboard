import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:desktop_clipboard/desktop_clipboard.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _desktopClipboardPlugin = DesktopClipboard();

  @override
  void initState() {
    super.initState();
  }

  Future<bool?> copyImageByPathToClipboard() async {
    bool? success;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (result != null) {
        success = await _desktopClipboardPlugin
            .copyImageByPath(result.files.single.path!);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      success = false;
    }
    return success;
  }

  Future<bool?> copyImageToClipboard() async {
    bool? success;
    String base64Image =
        "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";
    Uint8List bytes = base64.decode(base64Image);
    try {
      success = await _desktopClipboardPlugin.copyImage(bytes);
    } catch (e) {
      success = false;
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Copy Image To Clipboard Example'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    await copyImageByPathToClipboard().then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Copy Image By Path ${value != null && value ? "success" : "failed"}'))));
                  },
                  child: const Text("Copy Image By Path")),
              TextButton(
                  onPressed: () async {
                    await copyImageToClipboard().then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Copy Image By Binary ${value != null && value ? "success" : "failed"}'))));
                  },
                  child: const Text("Copy Image By Binary")),
            ],
          ),
        ));
  }
}
