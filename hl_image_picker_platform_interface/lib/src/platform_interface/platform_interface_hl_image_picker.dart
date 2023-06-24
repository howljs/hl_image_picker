import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../camera_options.dart';
import '../crop_options.dart';
import '../method_channel/method_channel_hl_image_picker.dart';
import '../picker_item.dart';
import '../picker_options.dart';
import '../picker_localized.dart';

abstract class HLImagePickerPlatform extends PlatformInterface {
  /// Constructs a HLImagePickerPlatform.
  HLImagePickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static HLImagePickerPlatform _instance = MethodChannelHLImagePicker();

  /// The default instance of [HLImagePickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelHLImagePicker].
  static HLImagePickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HLImagePickerPlatform] when
  /// they register themselves.
  static set instance(HLImagePickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<HLPickerItem>> openPicker({
    List<String>? selectedIds,
    HLPickerOptions? pickerOptions,
    bool? cropping,
    HLCropOptions? cropOptions,
    LocalizedImagePicker? localized,
  }) {
    throw UnimplementedError('openPicker() has not been implemented.');
  }

  Future<HLPickerItem> openCamera({
    HLCameraOptions? cameraOptions,
    bool? cropping,
    HLCropOptions? cropOptions,
    LocalizedImageCropper? localized,
  }) {
    throw UnimplementedError('openCamera() has not been implemented.');
  }

  Future<HLPickerItem> openCropper(
    String imagePath, {
    HLCropOptions? cropOptions,
    LocalizedImageCropper? localized,
  }) {
    throw UnimplementedError('openCropper() has not been implemented.');
  }
}
