import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hl_image_picker/hl_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final picker = await HLImagePicker().openPicker(
                    mediaType: MediaType.image,
                    cropping: true,
                    style: HLPickerStyle(
                      maxFileSizeErrorText: "File too big",
                      tapHereToChangeText: "Tap tap",
                      cropCancelText: "Back",
                      cropDoneText: "Finish",
                      cropTitleText: "Crop image",
                    ),
                  );
                  print(jsonEncode(picker));
                },
                child: const Text('Open Picker')),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final picker = await HLImagePicker().openCamera(
                      cameraType: CameraType.image,
                      cropping: true,
                      style: HLPickerStyle(
                        maxFileSizeErrorText: "File too big",
                        tapHereToChangeText: "Tap tap",
                        cropCancelText: "Back",
                        cropDoneText: "Finish",
                        cropTitleText: "Crop image",
                      ),
                    );
                    print(jsonEncode(picker));
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: const Text('Open Camera')),
          ],
        ),
      ),
    );
  }
}
