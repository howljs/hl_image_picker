import 'constants.dart';

class CropAspectRatio {
  const CropAspectRatio({required this.ratioX, required this.ratioY})
      : assert(ratioX > 0.0 && ratioY > 0.0);

  final double ratioX;
  final double ratioY;

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['ratioX'] = ratioX;
    data['ratioY'] = ratioY;
    return data;
  }
}

class MaxSizeOutput {
  const MaxSizeOutput({required this.maxWidth, required this.maxHeight});

  final int maxWidth;
  final int maxHeight;

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['maxWidth'] = maxWidth;
    data['maxHeight'] = maxHeight;
    return data;
  }
}

class HLCropOptions {
  const HLCropOptions({
    this.croppingStyle,
    this.aspectRatio,
    this.aspectRatioPresets,
    this.compressQuality,
    this.compressFormat,
    this.maxSizeOutput,
  });

  /// Specifies the desired aspect ratio for cropping.
  final CropAspectRatio? aspectRatio;

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
  final List<CropAspectRatioPreset>? aspectRatioPresets;

  /// Determines the compression quality for the exported image.
  ///
  /// Min: `0.1` - Max: `1`
  ///
  /// Default: `0.9`
  final double? compressQuality;

  /// Specifies the image format for the exported image: [CompressFormat.jpg], [CompressFormat.png].
  ///
  /// Default: [CompressFormat.jpg]
  final CompressFormat? compressFormat;

  /// Cropping style: [CroppingStyle.normal], [CroppingStyle.circular].
  ///
  /// Default: [CroppingStyle.normal]
  final CroppingStyle? croppingStyle;

  /// Sets the maximum width and maximum height for the exported image.
  final MaxSizeOutput? maxSizeOutput;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result['aspectRatio'] = aspectRatio?.toMap();
    result['aspectRatioPresets'] =
        aspectRatioPresets?.map((x) => x.value).toList();
    result['cropCompressQuality'] = compressQuality;
    result['cropCompressFormat'] = compressFormat?.name;
    result['croppingStyle'] = croppingStyle?.name;
    result['cropMaxSizeOutput'] = maxSizeOutput?.toMap();
    return result;
  }
}
