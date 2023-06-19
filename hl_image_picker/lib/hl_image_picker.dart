import 'package:flutter/material.dart';
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

class HLImagePicker {
  @visibleForTesting
  static HLImagePickerPlatform get platform => HLImagePickerPlatform.instance;

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
    bool? convertHeicToJPG,
    bool? convertLivePhotosToJPG,
  }) async {
    return platform.openPicker(
      mediaType: mediaType,
      maxSelectedAssets: maxSelectedAssets,
      usedCameraButton: usedCameraButton,
      selectedIds: selectedIds,
      maxFileSize: maxFileSize,
      cropping: cropping,
      isExportThumbnail: isExportThumbnail,
      enablePreview: enablePreview,
      numberOfColumn: numberOfColumn,
      aspectRatio: aspectRatio,
      aspectRatioPresets: aspectRatioPresets,
      compressQuality: compressQuality,
      compressFormat: compressFormat,
      thumbnailCompressQuality: thumbnailCompressQuality,
      thumbnailCompressFormat: thumbnailCompressFormat,
      recordVideoMaxSecond: recordVideoMaxSecond,
      maxDuration: maxDuration,
      style: style,
      convertHeicToJPG: convertHeicToJPG,
      convertLivePhotosToJPG: convertLivePhotosToJPG,
    );
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
  }) async {
    return platform.openCamera(
      cameraType: cameraType,
      cropping: cropping,
      aspectRatio: aspectRatio,
      aspectRatioPresets: aspectRatioPresets,
      compressQuality: compressQuality,
      compressFormat: compressFormat,
      recordVideoMaxSecond: recordVideoMaxSecond,
      isExportThumbnail: isExportThumbnail,
      thumbnailCompressQuality: thumbnailCompressQuality,
      thumbnailCompressFormat: thumbnailCompressFormat,
      style: style,
    );
  }
}
