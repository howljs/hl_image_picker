enum MediaType { image, video, all }

extension HLImagePickerTypeX on MediaType {
  String get value {
    switch (this) {
      case MediaType.image:
        return 'image';
      case MediaType.video:
        return 'video';
      default:
        return 'all';
    }
  }
}

enum CameraType { image, video }

extension CameraTypeX on CameraType {
  String get value {
    switch (this) {
      case CameraType.video:
        return 'video';
      default:
        return 'image';
    }
  }
}

class HLImagePickerItem {
  late final String path;
  late final String id;
  late final String name;
  late final String mimeType;
  late final int size;
  late final int width;
  late final int height;
  late final String type;

  /// Video duration
  late final double? duration;
  late final String? thumbnail;

  HLImagePickerItem({
    required this.path,
    required this.id,
    required this.name,
    required this.mimeType,
    required this.size,
    required this.width,
    required this.height,
    required this.type,
    this.duration,
    this.thumbnail,
  });

  HLImagePickerItem.fromJson(Map<dynamic, dynamic> json) {
    path = json['path'];
    id = json['id'];
    name = json['name'];
    mimeType = json['mimeType'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
    type = json['type'];
  }

  Map<dynamic, dynamic> toJson() {
    final data = <dynamic, dynamic>{};
    data['path'] = path;
    data['id'] = id;
    data['name'] = name;
    data['mimeType'] = mimeType;
    data['size'] = size;
    data['width'] = width;
    data['height'] = height;
    data['duration'] = duration;
    data['thumbnail'] = thumbnail;
    data['type'] = type;
    return data;
  }
}

class CropAspectRatio {
  final double ratioX;
  final double ratioY;
  const CropAspectRatio({required this.ratioX, required this.ratioY})
      : assert(ratioX > 0.0 && ratioY > 0.0);
}

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

enum CompressFormat { png, jpg }

extension CompressFormatX on CompressFormat {
  String get value {
    switch (this) {
      case CompressFormat.png:
        return 'png';
      default:
        return 'jpg';
    }
  }
}

class DefaultText {
  const DefaultText._();
  static const maxDurationErrorText = 'Duration error';
  static const maxFileSizeErrorText = 'File size error';
  static const noAlbumPermissionText = 'No album permission';
  static const noCameraPermissionText = 'No Camera permission';
  static const maxSelectedAssetsErrorText = 'Max selected assets';
  static const cancelText = 'Cancel';
  static const doneText = 'Done';

  // IOS
  static const tapHereToChangeText = 'Tap here';
  static const emptyMediaText = 'Empty media';
  static const loadingText = 'Loading...';
  static const okText = 'OK';
}

class HLPickerStyle {
  late final String maxDurationErrorText;
  late final String maxFileSizeErrorText;
  late final String noAlbumPermissionText;
  late final String noCameraPermissionText;
  late final String maxSelectedAssetsErrorText;
  late final String cancelText;
  late final String doneText;

  // IOS
  late final String tapHereToChangeText;
  late final String emptyMediaText;
  late final String loadingText;
  late final String okText;

  HLPickerStyle({
    this.maxDurationErrorText = DefaultText.maxDurationErrorText,
    this.maxFileSizeErrorText = DefaultText.maxFileSizeErrorText,
    this.noAlbumPermissionText = DefaultText.noAlbumPermissionText,
    this.noCameraPermissionText = DefaultText.noCameraPermissionText,
    this.maxSelectedAssetsErrorText = DefaultText.maxSelectedAssetsErrorText,
    this.cancelText = DefaultText.cancelText,
    this.doneText = DefaultText.doneText,
    this.tapHereToChangeText = DefaultText.tapHereToChangeText,
    this.emptyMediaText = DefaultText.emptyMediaText,
    this.loadingText = DefaultText.loadingText,
    this.okText = DefaultText.okText,
  });

  HLPickerStyle.fromJson(Map<String, dynamic> json) {
    maxDurationErrorText = json['maxDurationErrorText'];
    maxFileSizeErrorText = json['maxFileSizeErrorText'];
    noAlbumPermissionText = json['noAlbumPermissionText'];
    noCameraPermissionText = json['noCameraPermissionText'];
    maxSelectedAssetsErrorText = json['maxSelectedAssetsErrorText'];
    cancelText = json['cancelText'];
    doneText = json['doneText'];
    tapHereToChangeText = json['tapHereToChangeText'];
    emptyMediaText = json['emptyMediaText'];
    loadingText = json['loadingText'];
    okText = json['okText'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['maxDurationErrorText'] = maxDurationErrorText;
    data['maxFileSizeErrorText'] = maxFileSizeErrorText;
    data['noAlbumPermissionText'] = noAlbumPermissionText;
    data['noCameraPermissionText'] = noCameraPermissionText;
    data['maxSelectedAssetsErrorText'] = maxSelectedAssetsErrorText;
    data['cancelText'] = cancelText;
    data['doneText'] = doneText;
    data['tapHereToChangeText'] = tapHereToChangeText;
    data['emptyMediaText'] = emptyMediaText;
    data['loadingText'] = loadingText;
    data['okText'] = okText;
    return data;
  }
}
