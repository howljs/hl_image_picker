import 'package:hl_image_picker_platform_interface/hl_image_picker_platform_interface.dart';

class HLCameraOptions {
  const HLCameraOptions({
    this.cameraType,
    this.recordVideoMaxSecond,
    this.isExportThumbnail,
    this.compressQuality,
    this.compressFormat,
    this.thumbnailCompressQuality,
    this.thumbnailCompressFormat,
    this.maxSizeOutput,
  });

  /// Specifies the type of camera to be used: [CameraType.video], [CameraType.image]
  ///
  /// Default: [CameraType.image]
  final CameraType? cameraType;

  /// The maximum duration (in seconds) for recorded video.
  final int? recordVideoMaxSecond;

  /// Determines whether to export thumbnail for recorded video.
  final bool? isExportThumbnail;

  /// The compression quality for selected image.
  final double? compressQuality;

  /// The image format for selected image: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  final CompressFormat? compressFormat;

  /// The compression quality for exported thumbnail.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  final double? thumbnailCompressQuality;

  /// The image format for exported thumbnail: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  final CompressFormat? thumbnailCompressFormat;

  final MaxSizeOutput? maxSizeOutput;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result['cameraType'] = cameraType?.name;
    result['recordVideoMaxSecond'] = recordVideoMaxSecond;
    result['isExportThumbnail'] = isExportThumbnail;
    result['thumbnailCompressQuality'] = thumbnailCompressQuality;
    result['thumbnailCompressFormat'] = thumbnailCompressFormat;
    result['cameraCompressQuality'] = compressQuality;
    result['cameraCompressFormat'] = compressFormat;
    result['cameraMaxSizeOutput'] = maxSizeOutput?.toMap();
    return result;
  }
}
