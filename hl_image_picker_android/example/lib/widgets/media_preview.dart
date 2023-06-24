import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class MediaPreview extends StatelessWidget {
  const MediaPreview({
    super.key,
    required this.items,
  });

  final List<HLPickerItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        height: 240,
        color: Colors.grey[300],
        child: const Center(
          child: Text('Empty'),
        ),
      );
    }

    return SizedBox(
      height: 240,
      width: double.infinity,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (_, index) {
          File? imageFile = File(items[index].path);
          if (items[index].type == "video") {
            imageFile = items[index].thumbnail != null
                ? File(items[index].thumbnail!)
                : null;
          }
          return imageFile != null
              ? InkWell(
                  onTap: items[index].type == "video" ? () {} : null,
                  child: Image.file(imageFile))
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  width: 320,
                  height: double.infinity,
                  child: const Text('No thumbnail'));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8.0),
      ),
    );
  }
}
