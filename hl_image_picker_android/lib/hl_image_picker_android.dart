import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hl_image_picker_platform_interface/hl_image_picker_platform_interface.dart';
import 'package:hl_image_picker_platform_interface/hl_image_picker_types.dart';

export 'package:hl_image_picker_platform_interface/hl_image_picker_types.dart'
    show
        HLPickerStyle,
        HLImagePickerItem,
        MediaType,
        CropAspectRatio,
        CropAspectRatioPreset,
        CompressFormat,
        CameraType;

/// An implementation of [HLImagePickerPlatform] that uses method channels.
class HLImagePickerAndroid extends HLImagePickerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hl_image_picker');

  static void registerWith() {
    HLImagePickerPlatform.instance = HLImagePickerAndroid();
  }

  @override
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
  }) async {
    const defaultPresets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ];

    final data = await methodChannel.invokeMethod('openPicker', {
      'mediaType': mediaType?.value,
      'maxSelectedAssets': maxSelectedAssets,
      'usedCameraButton': usedCameraButton,
      'selectedIds': selectedIds,
      'maxFileSize': maxFileSize,
      'cropping': cropping,
      'isExportThumbnail': isExportThumbnail ?? mediaType == null,
      'enablePreview': enablePreview,
      'numberOfColumn': numberOfColumn,
      'ratioX': aspectRatio?.ratioX,
      'ratioY': aspectRatio?.ratioY,
      'aspectRatioPresets':
          (aspectRatioPresets ?? defaultPresets).map((e) => e.value).toList(),
      'compressQuality': compressQuality,
      'compressFormat': compressFormat?.value,
      'thumbnailCompressQuality': thumbnailCompressQuality,
      'thumbnailCompressFormat': thumbnailCompressFormat?.value,
      'recordVideoMaxSecond': recordVideoMaxSecond,
      'maxDuration': maxDuration,
      'convertLivePhotosToJPG': convertLivePhotosToJPG,
      'convertHeicToJPG': convertHeicToJPG,
      'style': style?.toJson() ?? HLPickerStyle().toJson(),
    });
    List<HLImagePickerItem> selectedItems = [];
    if (data != null) {
      selectedItems = (data as List)
          .map((item) => HLImagePickerItem.fromJson(item))
          .toList();
    }
    return selectedItems;
  }

  @override
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
  }) async {
    const defaultPresets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ];

    final data = await methodChannel.invokeMethod('openCamera', {
      'cameraType': cameraType?.value,
      'cropping': cropping,
      'ratioX': aspectRatio?.ratioX,
      'ratioY': aspectRatio?.ratioY,
      'aspectRatioPresets':
          (aspectRatioPresets ?? defaultPresets).map((e) => e.value).toList(),
      'compressQuality': compressQuality,
      'compressFormat': compressFormat?.value,
      'recordVideoMaxSecond': recordVideoMaxSecond,
      'isExportThumbnail': isExportThumbnail,
      'thumbnailCompressQuality': thumbnailCompressQuality,
      'thumbnailCompressFormat': thumbnailCompressFormat?.value,
      'style': style?.toJson() ?? HLPickerStyle().toJson(),
    });
    return HLImagePickerItem.fromJson(data);
  }
}
