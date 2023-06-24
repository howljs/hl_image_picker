import 'package:hl_image_picker_platform_interface/src/constants.dart';

class HLCameraOptions {
  /// Specifies the type of camera to be used: [CameraType.video], [CameraType.image]
  ///
  /// Default: [CameraType.image]
  CameraType? cameraType;

  /// The maximum duration (in seconds) for recorded video.
  ///
  /// Default: `60` seconds
  int? recordVideoMaxSecond;

  /// Determines whether to export thumbnail for recorded video.
  bool? isExportThumbnail;

  /// The compression quality for exported thumbnail.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  double? thumbnailCompressQuality;

  /// The image format for exported thumbnail: [CompressFormat.jpg], [CompressFormat.png].
  /// 
  /// Default: [CompressFormat.jpg]
  CompressFormat? thumbnailCompressFormat;

  HLCameraOptions({
    this.cameraType,
    this.recordVideoMaxSecond,
    this.isExportThumbnail,
    this.thumbnailCompressQuality,
    this.thumbnailCompressFormat,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result['cameraType'] = cameraType?.name;
    result['recordVideoMaxSecond'] = recordVideoMaxSecond;
    result['isExportThumbnail'] = isExportThumbnail;
    result['thumbnailCompressQuality'] = thumbnailCompressQuality;
    result['thumbnailCompressFormat'] = thumbnailCompressFormat;
    return result;
  }
}
