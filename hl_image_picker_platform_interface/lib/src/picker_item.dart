class HLPickerItem {
  late final String path;
  late final String id;
  late final String name;
  late final String mimeType;
  late final int size;
  late final int width;
  late final int height;
  late final String type;
  late final double? duration;
  late final String? thumbnail;

  HLPickerItem({
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

  HLPickerItem.fromMap(Map<dynamic, dynamic> json) {
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
