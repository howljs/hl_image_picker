enum CroppingStyle { normal, circular }

enum MediaType { image, video, all }

enum CameraType { image, video }

enum CompressFormat { png, jpg }

enum CropAspectRatioPreset {
  original,
  square,
  ratio3x2,
  ratio4x3,
  ratio5x3,
  ratio5x4,
  ratio16x9,
}

extension CropAspectRatioPresetX on CropAspectRatioPreset {
  String get value {
    switch (this) {
      case CropAspectRatioPreset.square:
        return 'square';
      case CropAspectRatioPreset.ratio3x2:
        return '3x2';
      case CropAspectRatioPreset.ratio4x3:
        return '4x3';
      case CropAspectRatioPreset.ratio5x3:
        return '5x3';
      case CropAspectRatioPreset.ratio5x4:
        return '5x4';
      case CropAspectRatioPreset.ratio16x9:
        return '16x9';
      default:
        return 'original';
    }
  }
}
