import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../platform_interface/platform_interface_hl_image_picker.dart';

/// An implementation of [HLImagePickerPlatform] that uses method channels.
class MethodChannelHLImagePicker extends HLImagePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.howl.plugin/hl_image_picker');
}
