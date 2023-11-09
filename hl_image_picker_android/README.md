# Flutter Image Picker Plugin

The Android implementation of [hl_image_picker](https://pub.dev/packages/hl_image_picker).

---

[![pub package](https://img.shields.io/pub/v/hl_image_picker_android.svg)](https://pub.dev/packages/hl_image_picker_android)
[![pub package](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

|             | Android |
| ----------- | ------- |
| **Support** | SDK 21+ |

Simplify media selection, cropping, and camera functionality in your Flutter app. Choose images/videos from the library, crop images, and capture new photos/videos with ease.

<p align="center">
  <img
      src="https://github.com/howljs/hl_image_picker/blob/main/__assets__/android_picker_sample.gif?raw=true"
      alt="Picker Android"
      width="160"
    />
</p>

---

## Installation

```sh
$ flutter pub add hl_image_picker_android
```

## Setup

To use the plugin, you need to perform the following setup steps:

1. Make sure you set the `minSdkVersion` in your `android/app/build.gradle` file from version 21 or later:

```gradle
android {
    ...
    defaultConfig {
        minSdkVersion 21
        ...
    }
}
```

2. Add permissions to your `AndroidManifest.xml` file.

```xml
<!-- Android 12 and lower -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- Targeting Android 13 or higher -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />

<!-- Request the camera permission -->
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-permission android:name="android.permission.CAMERA" />

<!-- Add this permission if you need to record videos -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

## Usage

### Select images/videos from library

```dart
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

final _picker = HLImagePickerAndroid();

List<HLPickerItem> _selectedImages = [];

_openPicker() async {
    final images = await _picker.openPicker(
        // Properties
    );
    setState(() {
        _selectedImages = images;
    });
}

```

**Properties**

| Property      | Description                                                                                                                                                  | Type                                          |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| selectedIds   | A list of string IDs representing the initially selected images or videos from the library. This allows users to pre-select items before opening the picker. | [String]                                      |
| pickerOptions | Additional options for the picker                                                                                                                            | [HLPickerOptions](#hlpickeroptions)           |
| cropping      | Indicating whether or not cropping is enabled. Just work when `mediaType = MediaType.image` and `maxSelectedAssets = 1`                                      | bool                                          |
| cropOptions   | Configuration options for the cropping functionality                                                                                                         | [HLCropOptions](#hlcropoptions)               |
| localized     | Custom text displayed for the plugin                                                                                                                         | [LocalizedImagePicker](#localizedimagepicker) |

### Take a photo or record a video

```dart
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

final _picker = HLImagePickerAndroid();

HLPickerItem? _selectedImage;

_openCamera() async {
    final image = await _picker.openCamera(
        // Properties
    );
    setState(() {
        _selectedImage = image;
    });
}
```

**Properties**

| Property      | Description                                          | Type                                |
| ------------- | ---------------------------------------------------- | ----------------------------------- |
| cameraOptions | Additional options for the camera functionality      | [HLCameraOptions](#hlcameraoptions) |
| cropping      | Indicating whether or not cropping is enabled        | bool                                |
| cropOptions   | Configuration options for the cropping functionality | [HLCropOptions](#hlcropoptions)     |

### Open image cropper

```dart
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

final _picker = HLImagePickerAndroid();

HLPickerItem? _selectedImage;

_openCropper_() async {
    final image = await _picker.openCropper("image_path_to_crop",
    // Properties
    );
    setState(() {
        _selectedImage = image;
    });
}
```

**Properties**

| Property    | Description                                          | Type                            |
| ----------- | ---------------------------------------------------- | ------------------------------- |
| imagePath   | Path of the image that needs to be cropped           | String                          |
| cropping    | Indicating whether or not cropping is enabled        | bool                            |
| cropOptions | Configuration options for the cropping functionality | [HLCropOptions](#hlcropoptions) |

| Normal                                                                                                                  | Circular                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/howljs/hl_image_picker/blob/main/__assets__/android_crop_square.png?raw=true" width="160"> | <img src="https://github.com/howljs/hl_image_picker/blob/main/__assets__/android_crop_circular.png?raw=true" width="160"> |

---

### HLPickerOptions

| Property                 | Description                                                                             | Default            |
| ------------------------ | --------------------------------------------------------------------------------------- | ------------------ |
| mediaType                | Type of media you want to select: `MediaType.image`, `MediaType.video`,`MediaType.all`. | MediaType.all      |
| maxSelectedAssets        | The maximum number of items that can be selected.                                       | 1                  |
| minSelectedAssets        | The minimum number of items that must be selected.                                      |                    |
| maxFileSize              | The maximum allowed file size (in KB) for selected items.                               |                    |
| minFileSize              | The minimum allowed file size (in KB) for selected items.                               |                    |
| enablePreview            | Enables or disables the preview feature.                                                | false              |
| recordVideoMaxSecond     | The maximum duration (in seconds) for recorded video.                                   | 60                 |
| isExportThumbnail        | Determines whether to export thumbnail for selected videos.                             | false              |
| thumbnailCompressQuality | The compression quality (0.1-1) for exported thumbnails.                                | 0.9                |
| thumbnailCompressFormat  | The image format for exported thumbnails: `CompressFormat.jpg`, `CompressFormat.png`.   | CompressFormat.jpg |
| maxDuration              | The maximum duration (in seconds) for selected videos.                                  |                    |
| minDuration              | The minimum duration (in seconds) for selected videos.                                  |                    |
| numberOfColumn           | The number of items displayed per row in the picker list.                               | 3                  |
| usedCameraButton         | Determines whether to show the camera button in the picker list.                        | true               |
| usedCameraButton         | Determines whether to show the camera button in the picker list.                        | true               |
| isGif                    | Enable gif selection                                                                    | false              |
| compressQuality          | Compress images with custom quality                                                     |                    |
| compressFormat           | The image format for compressed images                                                  | CompressFormat.jpg |
| maxSizeOutput            | Sets the maximum width and maximum height for selected images.                          |                    |

### HLCropOptions

| Property           | Description                                                                                    | Default              |
| ------------------ | ---------------------------------------------------------------------------------------------- | -------------------- |
| aspectRatio        | Specifies the desired aspect ratio for cropping.                                               |                      |
| aspectRatioPresets | Provides a set of predefined aspect ratio options for cropping.                                |                      |
| compressQuality    | Determines the compression quality (0.1-1) for the exported image.                             | 0.9                  |
| compressFormat     | Specifies the image format for the exported image: `CompressFormat.jpg`, `CompressFormat.png`. | CompressFormat.jpg   |
| croppingStyle      | Cropping style: `CroppingStyle.normal`, `CroppingStyle.circular`.                              | CroppingStyle.normal |
| maxSizeOutput      | Sets the maximum width and maximum height for the exported image.                              |                      |

### HLCameraOptions

| Property                 | Description                                                                          | Default            |
| ------------------------ | ------------------------------------------------------------------------------------ | ------------------ |
| cameraType               | Specifies the type of camera to be used: `CameraType.video`, `CameraType.image`      | CameraType.image   |
| recordVideoMaxSecond     | The maximum duration (in seconds) for recorded video.                                | 60                 |
| isExportThumbnail        | Determines whether to export thumbnail for recorded video.                           | false              |
| thumbnailCompressQuality | The compression quality (0.1-1) for exported thumbnail.                              | 0.9                |
| thumbnailCompressFormat  | The image format for exported thumbnail: `CompressFormat.jpg`, `CompressFormat.png`. | CompressFormat.jpg |
| compressQuality          | Compress images with custom quality                                                  |                    |
| compressFormat           | The image format for compressed images                                               | CompressFormat.jpg |
| maxSizeOutput            | Sets the maximum width and maximum height for selected images.                       |                    |

### HLPickerItem (Response)

| Property  | Description                                          | Type    |
| --------- | ---------------------------------------------------- | ------- |
| path      | The path of the item.                                | String  |
| id        | The unique identifier of the item.                   | String  |
| name      | The filename of the item.                            | String  |
| mimeType  | The MIME type of the item.                           | String  |
| size      | The size of the item in bytes.                       | int     |
| width     | The width of the item                                | int     |
| height    | The height of the item                               | int     |
| type      | Indicates whether the item is an `image` or `video`. | String  |
| duration  | The duration of the video                            | double? |
| thumbnail | The path of the video thumbnail                      | String? |

### LocalizedImagePicker

| Property                    | Description                                                                            | Default                                     |
| --------------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------- |
| maxDurationErrorText        | The error message displayed when the selected video exceeds the maximum duration.      | Exceeded maximum duration of the video      |
| minDurationErrorText        | The error message displayed when the selected video is below the minimum duration.     | The video is too short                      |
| maxFileSizeErrorText        | The error message displayed when the selected file exceeds the maximum file size.      | Exceeded maximum file size                  |
| minFileSizeErrorText        | The error message displayed when the selected file is below the minimum file size.     | The file size is too small                  |
| noAlbumPermissionText       | The error message displayed when the app doesn't have permission to access the album.  | No permission to access album               |
| noCameraPermissionText      | The error message displayed when the app doesn't have permission to access the camera. | No permission to access camera              |
| maxSelectedAssetsErrorText  | The error message displayed when the maximum number of items is exceeded.              | Exceeded maximum number of selected items   |
| minSelectedAssetsErrorText  | The error message displayed when the minimum number of items is not met.               | Need to select at least {minSelectedAssets} |
| noRecordAudioPermissionText | The error message displayed when the app doesn't have permission to record audio.      | No permission to record audio               |
| doneText                    | The text displayed on the "Done" button.                                               | Done                                        |
| cancelText                  | The text displayed on the "Cancel" button.                                             | Cancel                                      |
| loadingText                 | The text displayed when the picker is in a loading state.                              | Loading                                     |
| defaultAlbumName            | The name for default album.                                                            | Recents                                     |
| okText                      | The text displayed on the "OK" button.                                                 | OK                                          |

## ProGuard

```
-keep class com.luck.picture.lib.** { *; }
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }
```

## Open-source library

[PictureSelector](https://github.com/LuckSiege/PictureSelector)
