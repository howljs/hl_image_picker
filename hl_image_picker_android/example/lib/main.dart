import 'package:flutter/material.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

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
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                final picker = await HLImagePickerAndroid().openPicker();
                print(picker);
              },
              child: const Text('Open Picker')),
        ),
      ),
    );
  }
}
