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

class HLPickerStyle {
  /// Default value:
  ///
  /// **'Exceeded maximum duration of the video'**
  late final String? maxDurationErrorText;

  /// Default value:
  ///
  /// **'Maximum file size exceeded'**
  late final String? maxFileSizeErrorText;

  /// Default value:
  ///
  /// **'The album could not be launched. Please allow access to and try again.'**
  late final String? noAlbumPermissionText;

  /// Default value:
  ///
  /// **'The camera could not be started. Please allow camera access and try again.'**
  late final String? noCameraPermissionText;

  /// Default value:
  ///
  /// **'Exceeded maximum amount of assets'**
  late final String? maxSelectedAssetsErrorText;

  /// Default value:
  ///
  /// **'Done'**
  late final String? doneText;

  /// (Android only) Default value:
  ///
  /// **'Audio recording permission denied'**
  late final String? noRecordAudioPermissionText;

  /// Default value:
  ///
  /// **'OK'**
  late final String? okText;

  /// Default value:
  ///
  /// **'Loading'**
  late final String? loadingText;

  /// Default value:
  ///
  /// **'Recents'**
  late final String? defaultAlbumName;

  /// (iOS Only) Default value:
  ///
  /// **'Cancel'**
  late final String? cancelText;

  /// (iOS Only) Default value:
  ///
  /// **'Tap here to change'**
  late final String? tapHereToChangeText;

  /// (iOS Only) Default value:
  ///
  /// **'No albums'**
  late final String? emptyMediaText;

  /// (iOS Only) Default value:
  ///
  /// **'Done'**
  late final String? cropDoneText;

  /// (iOS Only) Default value:
  ///
  /// **'Cancel'**
  late final String? cropCancelText;

  late final String? cropTitleText;

  HLPickerStyle({
    this.maxDurationErrorText,
    this.maxFileSizeErrorText,
    this.noAlbumPermissionText,
    this.noCameraPermissionText,
    this.maxSelectedAssetsErrorText,
    this.noRecordAudioPermissionText,
    this.cancelText,
    this.doneText,
    this.tapHereToChangeText,
    this.emptyMediaText,
    this.loadingText,
    this.okText,
    this.cropDoneText,
    this.cropCancelText,
    this.cropTitleText,
    this.defaultAlbumName,
  });

  HLPickerStyle.fromJson(Map<String, dynamic> json) {
    maxDurationErrorText = json['maxDurationErrorText'];
    maxFileSizeErrorText = json['maxFileSizeErrorText'];
    noAlbumPermissionText = json['noAlbumPermissionText'];
    noCameraPermissionText = json['noCameraPermissionText'];
    maxSelectedAssetsErrorText = json['maxSelectedAssetsErrorText'];
    noRecordAudioPermissionText = json['noRecordAudioPermissionText'];
    cancelText = json['cancelText'];
    doneText = json['doneText'];
    tapHereToChangeText = json['tapHereToChangeText'];
    emptyMediaText = json['emptyMediaText'];
    loadingText = json['loadingText'];
    okText = json['okText'];
    cropTitleText = json['cropTitleText'];
    cropDoneText = json['cropDoneText'];
    cropCancelText = json['cropCancelText'];
    defaultAlbumName = json['defaultAlbumName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['maxDurationErrorText'] = maxDurationErrorText;
    data['maxFileSizeErrorText'] = maxFileSizeErrorText;
    data['noAlbumPermissionText'] = noAlbumPermissionText;
    data['noCameraPermissionText'] = noCameraPermissionText;
    data['maxSelectedAssetsErrorText'] = maxSelectedAssetsErrorText;
    data['noRecordAudioPermissionText'] = noRecordAudioPermissionText;
    data['cancelText'] = cancelText;
    data['doneText'] = doneText;
    data['tapHereToChangeText'] = tapHereToChangeText;
    data['emptyMediaText'] = emptyMediaText;
    data['loadingText'] = loadingText;
    data['okText'] = okText;
    data['cropTitleText'] = cropTitleText;
    data['cropDoneText'] = cropDoneText;
    data['cropCancelText'] = cropCancelText;
    data['defaultAlbumName'] = defaultAlbumName;
    return data;
  }
}
