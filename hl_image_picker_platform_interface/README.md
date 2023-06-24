# hl_image_picker_platform_interface

A common platform interface for the [hl_image_picker](https://pub.dev/packages/hl_image_picker) plugin.

## Usage

To implement a new platform-specific implementation of `hl_image_picker`, 
1. Extend **HLImagePickerPlatform** with an implementation that performs the platform-specific behavior.
2. When you register your plugin, set the default HLImagePickerPlatform by calling HLImagePickerPlatform.instance = HLImagePickerPlatform().
