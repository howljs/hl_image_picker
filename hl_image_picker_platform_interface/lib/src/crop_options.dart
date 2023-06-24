import 'constants.dart';

class CropAspectRatio {
  final double ratioX;
  final double ratioY;
  const CropAspectRatio({required this.ratioX, required this.ratioY})
      : assert(ratioX > 0.0 && ratioY > 0.0);

  Map<dynamic, dynamic> toMap() {
    final data = <dynamic, dynamic>{};
    data['ratioX'] = ratioX;
    data['ratioY'] = ratioY;
    return data;
  }
}

class MaxSizeOutput {
  final int maxWidth;
  final int maxHeight;

  MaxSizeOutput({required this.maxWidth, required this.maxHeight});

  Map<dynamic, dynamic> toMap() {
    final data = <dynamic, dynamic>{};
    data['maxWidth'] = maxWidth;
    data['maxHeight'] = maxHeight;
    return data;
  }
}

class HLCropOptions {
  /// Specifies the desired aspect ratio for cropping.
  CropAspectRatio? aspectRatio;

  /// Provides a set of predefined aspect ratio options for cropping.
  ///
  /// Default:
  /// ```
  ///  [
  ///    CropAspectRatioPreset.original,
  ///    CropAspectRatioPreset.square,
  ///    CropAspectRatioPreset.ratio3x2,
  ///    CropAspectRatioPreset.ratio4x3,
  ///    CropAspectRatioPreset.ratio16x9
  ///  ];
  /// ```
  ///
  List<CropAspectRatioPreset>? aspectRatioPresets;

  /// Determines the compression quality for the exported image.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  double? compressQuality;

  /// Specifies the image format for the exported image: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  CompressFormat? compressFormat;

  /// Cropping style: [CroppingStyle.normal], [CroppingStyle.circular].
  ///
  /// Default: [CroppingStyle.normal]
  CroppingStyle? croppingStyle;

  /// Sets the maximum width and maximum height for the exported image.
  MaxSizeOutput? maxSizeOutput;

  HLCropOptions({
    this.croppingStyle,
    this.aspectRatio,
    this.aspectRatioPresets,
    this.compressQuality,
    this.compressFormat,
    this.maxSizeOutput,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result['aspectRatio'] = aspectRatio?.toMap();
    result['aspectRatioPresets'] =
        aspectRatioPresets?.map((x) => x.value).toList();
    result['compressQuality'] = compressQuality;
    result['compressFormat'] = compressFormat?.name;
    result['croppingStyle'] = croppingStyle?.name;
    result['maxSizeOutput'] = maxSizeOutput?.toMap();
    return result;
  }
}
