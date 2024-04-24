class HLPickerItem {
  const HLPickerItem({
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

  final String path;
  final String id;
  final String name;
  final String mimeType;
  final int size;
  final int width;
  final int height;
  final String type;
  final double? duration;
  final String? thumbnail;

  factory HLPickerItem.fromMap(Map<dynamic, dynamic> json) => HLPickerItem(
        path: Uri.decodeFull(json['path']),
        id: json['id'],
        name: json['name'],
        mimeType: json['mimeType'],
        size: json['size'],
        width: json['width'],
        height: json['height'],
        duration: json['duration'],
        thumbnail: json['thumbnail'],
        type: json['type'],
      );

  Map<dynamic, dynamic> toMap() {
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
