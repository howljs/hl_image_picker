import 'package:hl_image_picker_platform_interface/src/crop_options.dart';

import 'constants.dart';

class HLPickerOptions {
  const HLPickerOptions({
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
    @Deprecated('Use maxDuration instead') this.recordVideoMaxSecond,
    this.thumbnailCompressQuality,
    this.thumbnailCompressFormat,
    this.maxDuration,
    this.minDuration,
    this.isGif,
    this.compressFormat,
    this.compressQuality,
    this.maxSizeOutput,
  });

  /// Type of media you want to select: [MediaType.image], [MediaType.video], [MediaType.all].
  ///
  /// Default: [MediaType.all]
  final MediaType? mediaType;

  /// The maximum number of items that can be selected.
  ///
  /// Default: 1
  final int? maxSelectedAssets;

  /// The minimum number of items that must be selected.
  final int? minSelectedAssets;

  /// The maximum allowed file size for selected items.
  final double? maxFileSize;

  /// The minimum allowed file size for selected items.
  final double? minFileSize;

  /// Enables or disables the preview feature.
  ///
  /// **Press** on **Android** / **Long Press** on **iOS**
  final bool? enablePreview;

  /// Converts HEIC format images to JPEG format when selected.
  ///
  /// Platform: iOS
  final bool? convertHeicToJPG;

  /// Converts Live Photos to JPEG format when selected.
  ///
  /// Platform: iOS
  final bool? convertLivePhotosToJPG;

  /// The maximum duration (in seconds) for recorded video.
  final int? recordVideoMaxSecond;

  /// Determines whether to export thumbnail for selected videos.
  ///
  /// Default: `false`
  final bool? isExportThumbnail;

  /// The compression quality for exported thumbnails.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  final double? thumbnailCompressQuality;

  /// The image format for exported thumbnails: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  final CompressFormat? thumbnailCompressFormat;

  /// The maximum duration (in seconds) for selected videos.
  final int? maxDuration;

  /// The minimum duration (in seconds) for selected videos.
  final int? minDuration;

  /// The number of items displayed per row in the picker list.
  ///
  /// Default value: `3`
  final int? numberOfColumn;

  /// Determines whether to show the camera button in the picker list.
  ///
  /// Default value: `true`
  final bool? usedCameraButton;

  /// Enable gif selection
  ///
  /// Default: `false`
  final bool? isGif;

  /// The compression quality for compressed images.
  final double? compressQuality;

  /// The image format for compressed images: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  final CompressFormat? compressFormat;

  /// Sets the maximum width and maximum height for selected images.
  final MaxSizeOutput? maxSizeOutput;

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
    result['maxDuration'] = maxDuration;
    result['minDuration'] = minDuration;
    result['isExportThumbnail'] = isExportThumbnail;
    result['thumbnailCompressFormat'] = thumbnailCompressFormat;
    result['thumbnailCompressQuality'] = thumbnailCompressQuality;
    result['numberOfColumn'] = numberOfColumn;
    result['usedCameraButton'] = usedCameraButton;
    result['isGif'] = isGif;
    result['compressQuality'] = compressQuality;
    result['compressFormat'] = compressFormat;
    result['maxSizeOutput'] = maxSizeOutput?.toMap();
    return result;
  }
}
