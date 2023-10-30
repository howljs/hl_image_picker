import 'constants.dart';

class HLPickerOptions {
  HLPickerOptions({
    this.numberOfColumn,
    this.usedCameraButton,
    this.mediaType,
    this.maxSelectedAssets,
    this.minSelectedAssets,
    this.maxFileSize,
    this.minFileSize,
    this.enablePreview,
    this.convertHeicToJPG,
    this.convertLivePhotosToJPG,
    this.isExportThumbnail,
    this.recordVideoMaxSecond,
    this.thumbnailCompressQuality,
    this.thumbnailCompressFormat,
    this.maxDuration,
    this.minDuration,
    this.isGif,
  });

  /// Type of media you want to select: [MediaType.image], [MediaType.video], [MediaType.all].
  ///
  /// Default: [MediaType.all]
  MediaType? mediaType;

  /// The maximum number of items that can be selected.
  ///
  /// Default: 1
  int? maxSelectedAssets;

  /// The minimum number of items that must be selected.
  int? minSelectedAssets;

  /// The maximum allowed file size for selected items.
  double? maxFileSize;

  /// The minimum allowed file size for selected items.
  double? minFileSize;

  /// Enables or disables the preview feature.
  ///
  /// **Press** on **Android** / **Long Press** on **iOS**
  bool? enablePreview;

  /// Converts HEIC format images to JPEG format when selected.
  ///
  /// Platform: iOS
  bool? convertHeicToJPG;

  /// Converts Live Photos to JPEG format when selected.
  ///
  /// Platform: iOS
  bool? convertLivePhotosToJPG;

  /// The maximum duration (in seconds) for recorded video.
  ///
  /// Default: `60` seconds
  int? recordVideoMaxSecond;

  /// Determines whether to export thumbnail for selected videos.
  ///
  /// Default: `false`
  bool? isExportThumbnail;

  /// The compression quality for exported thumbnails.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  double? thumbnailCompressQuality;

  /// The image format for exported thumbnails: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  CompressFormat? thumbnailCompressFormat;

  /// The maximum duration (in seconds) for selected videos.
  int? maxDuration;

  /// The minimum duration (in seconds) for selected videos.
  int? minDuration;

  /// The number of items displayed per row in the picker list.
  ///
  /// Default value: `3`
  late final int? numberOfColumn;

  /// Determines whether to show the camera button in the picker list.
  ///
  /// Default value: `true`
  late final bool? usedCameraButton;

  bool? isGif;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result['mediaType'] = mediaType?.name;
    result['maxSelectedAssets'] = maxSelectedAssets;
    result['minSelectedAssets'] = minSelectedAssets;
    result['maxFileSize'] = maxFileSize;
    result['minFileSize'] = minFileSize;
    result['enablePreview'] = enablePreview;
    result['convertHeicToJPG'] = convertHeicToJPG;
    result['convertLivePhotosToJPG'] = convertLivePhotosToJPG;
    result['recordVideoMaxSecond'] = recordVideoMaxSecond;
    result['maxDuration'] = maxDuration;
    result['minDuration'] = minDuration;
    result['isExportThumbnail'] = isExportThumbnail;
    result['thumbnailCompressFormat'] = thumbnailCompressFormat;
    result['thumbnailCompressQuality'] = thumbnailCompressQuality;
    result['numberOfColumn'] = numberOfColumn;
    result['usedCameraButton'] = usedCameraButton;
    result['isGif'] = isGif;
    return result;
  }
}
