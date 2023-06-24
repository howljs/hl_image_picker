import 'package:flutter/material.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class MediaTypeSelect extends StatelessWidget {
  const MediaTypeSelect({super.key, required this.value, this.onChanged});

  final MediaType value;

  final void Function(MediaType? type)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Media type'),
        const SizedBox(width: 16),
        DropdownButton(
          items: const [
            DropdownMenuItem(
              value: MediaType.all,
              child: Text('All'),
            ),
            DropdownMenuItem(
              value: MediaType.image,
              child: Text('Image'),
            ),
            DropdownMenuItem(
              value: MediaType.video,
              child: Text('Video'),
            ),
          ],
          value: value,
          onChanged: onChanged,
        )
      ],
    );
  }
}
