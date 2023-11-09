class LocalizedImageCropper {
  const LocalizedImageCropper({
    this.cropDoneText,
    this.cropCancelText,
    this.cropTitleText,
  });

  /// The text displayed on the "Done" button.
  ///
  /// Platform: **iOS**
  ///
  /// Default:
  /// **'Done'**
  final String? cropDoneText;

  /// The text displayed on the "Done" button.
  ///
  /// Platform: **iOS**
  ///
  /// Default:
  /// **'Cancel'**
  final String? cropCancelText;

  /// The title displayed in the crop image screen.
  final String? cropTitleText;

  factory LocalizedImageCropper.fromMap(Map<String, dynamic> map) =>
      LocalizedImageCropper(
        cropDoneText: map['cropDoneText'],
        cropCancelText: map['cropCancelText'],
        cropTitleText: map['cropTitleText'],
      );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['cropTitleText'] = cropTitleText;
    data['cropDoneText'] = cropDoneText;
    data['cropCancelText'] = cropCancelText;
    return data;
  }
}

class LocalizedImagePicker extends LocalizedImageCropper {
  const LocalizedImagePicker({
    this.maxDurationErrorText,
    this.minDurationErrorText,
    this.maxFileSizeErrorText,
    this.minFileSizeErrorText,
    this.noAlbumPermissionText,
    this.noCameraPermissionText,
    this.maxSelectedAssetsErrorText,
    this.minSelectedAssetsErrorText,
    this.doneText,
    this.noRecordAudioPermissionText,
    this.okText,
    this.loadingText,
    this.defaultAlbumName,
    this.cancelText,
    this.tapHereToChangeText,
    this.emptyMediaText,
    this.gifErrorText,
    super.cropDoneText,
    super.cropCancelText,
    super.cropTitleText,
  });

  /// The error message displayed when the selected video exceeds the maximum duration.
  ///
  /// Default:
  /// **'Exceeded maximum duration of the video'**
  final String? maxDurationErrorText;

  /// The error message displayed when the selected video is below the minimum duration.
  ///
  /// Default:
  /// **'The video is too short'**
  final String? minDurationErrorText;

  /// The error message displayed when the selected file exceeds the maximum file size.
  ///
  /// Default:
  /// **'Exceeded maximum file size'**
  final String? maxFileSizeErrorText;

  /// The error message displayed when the selected file is below the minimum file size.
  ///
  /// Default:
  /// **'The file size is too small'**
  final String? minFileSizeErrorText;

  /// The error message displayed when the app doesn't have permission to access the album.
  ///
  /// Default:
  /// **'No permission to access album'**
  final String? noAlbumPermissionText;

  /// The error message displayed when the app doesn't have permission to access the camera.
  ///
  /// Default:
  /// **'TNo permission to access camera'**
  final String? noCameraPermissionText;

  /// The error message displayed when the maximum number of items is exceeded.
  ///
  /// Default:
  /// **'Exceeded maximum number of selected items'**
  final String? maxSelectedAssetsErrorText;

  /// The error message displayed when the minimum number of items is not met.
  ///
  /// Default:
  /// **'Need to select at least {minSelectedAssets}'**
  final String? minSelectedAssetsErrorText;

  /// The text displayed on the "Done" button.
  ///
  /// Default:
  /// **'Done'**
  final String? doneText;

  /// The error message displayed when the app doesn't have permission to record audio.
  ///
  /// Platform: **Android**
  ///
  /// Default:
  /// **'No permission to record audio'**
  final String? noRecordAudioPermissionText;

  /// The text displayed on the "OK" button.
  ///
  /// Default:
  /// **'OK'**
  final String? okText;

  /// The text displayed when the picker is in a loading state.
  ///
  /// Default:
  /// **'Loading'**
  final String? loadingText;

  /// The name for default album.
  ///
  /// Default:
  /// **'Recents'**
  final String? defaultAlbumName;

  /// The text displayed on the "Cancel" button.
  ///
  /// Default:
  /// **'Cancel'**
  final String? cancelText;

  /// The text displayed below `defaultAlbumName`.
  ///
  /// Platform: **iOS**
  ///
  /// Default:
  /// **'Tap here to change'**
  final String? tapHereToChangeText;

  /// The text displayed when no media is available.
  ///
  /// Default:
  /// **'No media available'**
  final String? emptyMediaText;

  /// The text displayed when no media is available.
  ///
  /// Default:
  /// **'File type is not supported'**
  final String? gifErrorText;

  @override
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['maxDurationErrorText'] = maxDurationErrorText;
    data['minDurationErrorText'] = minDurationErrorText;
    data['maxFileSizeErrorText'] = maxFileSizeErrorText;
    data['minFileSizeErrorText'] = minFileSizeErrorText;
    data['noAlbumPermissionText'] = noAlbumPermissionText;
    data['noCameraPermissionText'] = noCameraPermissionText;
    data['maxSelectedAssetsErrorText'] = maxSelectedAssetsErrorText;
    data['minSelectedAssetsErrorText'] = minSelectedAssetsErrorText;
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
    data['gifErrorText'] = gifErrorText;
    return data;
  }
}
