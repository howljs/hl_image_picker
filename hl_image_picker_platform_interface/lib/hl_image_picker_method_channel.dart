import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hl_image_picker_platform_interface.dart';

/// An implementation of [HLImagePickerPlatform] that uses method channels.
class MethodChannelHLImagePicker extends HLImagePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.howl.plugin/hl_image_picker');
}
