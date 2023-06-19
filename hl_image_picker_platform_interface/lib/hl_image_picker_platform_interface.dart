import 'package:hl_image_picker_platform_interface/hl_image_picker_types.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hl_image_picker_method_channel.dart';

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

  Future<List<HLImagePickerItem>> openPicker({
    MediaType? mediaType,
    int? maxSelectedAssets,
    bool? usedCameraButton,
    List<String>? selectedIds,
    int? maxFileSize,
    bool? cropping,
    bool? isExportThumbnail,
    bool? enablePreview,
    int? numberOfColumn,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    double? compressQuality,
    CompressFormat? compressFormat,
    double? thumbnailCompressQuality,
    CompressFormat? thumbnailCompressFormat,
    int? recordVideoMaxSecond,
    int? maxDuration,
    HLPickerStyle? style,
    bool? convertLivePhotosToJPG,
    bool? convertHeicToJPG,
  }) {
    throw UnimplementedError('openPicker() has not been implemented.');
  }

  Future<HLImagePickerItem> openCamera({
    CameraType? cameraType,
    bool? cropping,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    double? compressQuality,
    CompressFormat? compressFormat,
    int? recordVideoMaxSecond,
    bool? isExportThumbnail,
    double? thumbnailCompressQuality,
    CompressFormat? thumbnailCompressFormat,
    HLPickerStyle? style,
  }) {
    throw UnimplementedError('openCamera() has not been implemented.');
  }
}
