import 'package:flutter/material.dart';
import 'package:hl_image_picker_ios/hl_image_picker_ios.dart';
import 'package:hl_image_picker_ios_example/widgets/aspect_ratio_select.dart';
import 'package:hl_image_picker_ios_example/widgets/custom_switch.dart';
import 'package:hl_image_picker_ios_example/widgets/increase_decrease.dart';
import 'package:hl_image_picker_ios_example/widgets/media_preview.dart';
import 'package:hl_image_picker_ios_example/widgets/media_type_select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Picker Demo',
      home: MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _picker = HLImagePickerIOS();

  List<HLPickerItem> _selectedImages = [];

  bool _isCroppingEnabled = false;
  int _count = 4;
  MediaType _type = MediaType.all;
  bool _isExportThumbnail = true;
  bool _enablePreview = false;
  bool _usedCameraButton = true;
  int _numberOfColumn = 3;
  bool _includePrevSelected = false;
  CropAspectRatio? _aspectRatio;
  List<CropAspectRatioPreset>? _aspectRatioPresets;
  double _compressQuality = 0.9;

  _openPicker() async {
    try {
      final images = await _picker.openPicker(
        cropping: _isCroppingEnabled,
        selectedIds: _includePrevSelected
            ? _selectedImages.map((e) => e.id).toList()
            : null,
        pickerOptions: HLPickerOptions(
          mediaType: _type,
          enablePreview: _enablePreview,
          isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
          maxSelectedAssets: _isCroppingEnabled ? 1 : _count,
          usedCameraButton: _usedCameraButton,
          numberOfColumn: _numberOfColumn,
          isGif: true,
        ),
        cropOptions: HLCropOptions(
          aspectRatio: _aspectRatio,
          aspectRatioPresets: _aspectRatioPresets,
          compressQuality: _compressQuality,
          compressFormat: CompressFormat.jpg,
        ),
      );
      setState(() {
        _selectedImages = images;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _openCamera() async {
    try {
      final image = await _picker.openCamera(
        cropping: _isCroppingEnabled,
        cameraOptions: HLCameraOptions(
          cameraType:
              _type == MediaType.video ? CameraType.video : CameraType.image,
          recordVideoMaxSecond: 40,
          isExportThumbnail: _isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
        ),
        cropOptions: HLCropOptions(
          aspectRatio: _aspectRatio,
          aspectRatioPresets: _aspectRatioPresets,
        ),
      );
      setState(() {
        _selectedImages = [image];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _openCropper() async {
    try {
      if (_selectedImages.isEmpty) {
        return;
      }
      final image = await _picker.openCropper(
        _selectedImages[0].path,
        cropOptions: HLCropOptions(
          aspectRatio: _aspectRatio,
          aspectRatioPresets: _aspectRatioPresets,
          compressQuality: _compressQuality,
          compressFormat: CompressFormat.jpg,
        ),
      );
      setState(() {
        _selectedImages = [image];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaPreview(items: _selectedImages),
              Align(
                child: ElevatedButton(
                  onPressed: _openPicker,
                  child: const Text('Open Picker'),
                ),
              ),
              Align(
                child: ElevatedButton(
                  onPressed: _openCamera,
                  child: const Text('Open camera'),
                ),
              ),
              Align(
                child: ElevatedButton(
                  onPressed: _selectedImages.isNotEmpty ? _openCropper : null,
                  child: const Text('Open cropper'),
                ),
              ),

              // Configuration
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text('Configuration',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    MediaTypeSelect(
                      value: _type,
                      onChanged: (value) {
                        if (value != null && value != _type) {
                          setState(() {
                            _type = value;
                            _isCroppingEnabled = false;
                          });
                        }
                      },
                    ),
                    ..._type == MediaType.image
                        ? [
                            CustomSwitch(
                              label: 'Enable cropping',
                              value: _isCroppingEnabled,
                              onChanged: (value) => setState(() {
                                _isCroppingEnabled = value;
                              }),
                            ),
                          ]
                        : [
                            CustomSwitch(
                              label: 'Generate video thumbnail',
                              value: _isExportThumbnail,
                              onChanged: (value) => setState(() {
                                _isExportThumbnail = value;
                              }),
                            ),
                          ],

                    ..._isCroppingEnabled
                        ? [
                            AspectRatioSelect(
                                aspectRatio: _aspectRatio,
                                aspectRatioPresets: _aspectRatioPresets,
                                onChangedPreset: (preset, value) {
                                  setState(() {
                                    if (_aspectRatioPresets == null) {
                                      _aspectRatioPresets = [preset];
                                    } else {
                                      if (value) {
                                        _aspectRatioPresets!.add(preset);
                                      } else {
                                        _aspectRatioPresets!.remove(preset);
                                        if (_aspectRatioPresets!.isEmpty) {
                                          _aspectRatioPresets = null;
                                        }
                                      }
                                    }
                                  });
                                },
                                onChangeCustomRatio: (newRatio) => {
                                      setState(() {
                                        _aspectRatio = newRatio;
                                      })
                                    }),
                            const SizedBox(height: 16),
                            Text("Compress quality ($_compressQuality)"),
                            Slider(
                                label: "$_compressQuality",
                                value: _compressQuality,
                                min: 0.1,
                                max: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _compressQuality =
                                        double.parse(value.toStringAsFixed(1));
                                  });
                                }),
                          ]
                        : [
                            IncreaseAndDecrease(
                                label: "Max selected assets",
                                value: _count,
                                onChanged: (value) => setState(() {
                                      _count = value;
                                    }))
                          ],

                    // Common
                    const Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: Text('Common Configuration',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    CustomSwitch(
                      label: 'Enable preview',
                      value: _enablePreview,
                      onChanged: (value) => setState(() {
                        _enablePreview = value;
                      }),
                    ),
                    CustomSwitch(
                      label: 'Show camera button in picker',
                      value: _usedCameraButton,
                      onChanged: (value) => setState(() {
                        _usedCameraButton = value;
                      }),
                    ),
                    CustomSwitch(
                      label: 'Include previously selected items',
                      value: _includePrevSelected,
                      onChanged: (value) => setState(() {
                        _includePrevSelected = value;
                      }),
                    ),
                    IncreaseAndDecrease(
                        label: "Number of columns",
                        value: _numberOfColumn,
                        onChanged: (value) => setState(() {
                              _numberOfColumn = value;
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
