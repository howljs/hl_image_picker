import 'package:flutter/material.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';
import 'package:hl_image_picker_android_example/widgets/increase_decrease.dart';

enum AspectRatioSelectType { presets, custom }

class AspectRatioSelect extends StatefulWidget {
  const AspectRatioSelect({
    super.key,
    this.aspectRatio,
    this.aspectRatioPresets,
    required this.onChangedPreset,
    required this.onChangeCustomRatio,
  });

  final CropAspectRatio? aspectRatio;
  final List<CropAspectRatioPreset>? aspectRatioPresets;
  final Function(CropAspectRatioPreset preset, bool value) onChangedPreset;
  final Function(CropAspectRatio aspectRatio) onChangeCustomRatio;

  @override
  State<AspectRatioSelect> createState() => _AspectRatioSelectState();
}

class _AspectRatioSelectState extends State<AspectRatioSelect> {
  AspectRatioSelectType _aspectRatioValue = AspectRatioSelectType.presets;

  @override
  Widget build(BuildContext context) {
    List<CropAspectRatioPreset> presets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio16x9,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
    ];
    bool isPresets = _aspectRatioValue == AspectRatioSelectType.presets;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Aspect ratio'),
            const SizedBox(width: 16),
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: AspectRatioSelectType.presets,
                  child: Text('Presets'),
                ),
                DropdownMenuItem(
                  value: AspectRatioSelectType.custom,
                  child: Text('Custom'),
                ),
              ],
              value: _aspectRatioValue,
              onChanged: (value) {
                if (value != null) {
                  if (value == AspectRatioSelectType.custom) {
                    widget.onChangeCustomRatio(
                        const CropAspectRatio(ratioX: 1, ratioY: 1));
                  }
                  setState(() {
                    _aspectRatioValue = value;
                  });
                }
              },
            )
          ],
        ),
        const SizedBox(height: 16),
        ...isPresets
            ? presets
                .map((p) => CheckboxListTile(
                      title: Text(p.name),
                      value: widget.aspectRatioPresets?.contains(p) ?? false,
                      dense: true,
                      onChanged: (newValue) =>
                          widget.onChangedPreset(p, newValue ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                    ))
                .toList()
            : [
                IncreaseAndDecrease(
                  value: widget.aspectRatio?.ratioX.toInt() ?? 1,
                  onChanged: (value) =>
                      widget.onChangeCustomRatio(CropAspectRatio(
                    ratioX: value.toDouble(),
                    ratioY: widget.aspectRatio?.ratioY ?? 1,
                  )),
                  label: 'RatioX',
                ),
                IncreaseAndDecrease(
                  value: widget.aspectRatio?.ratioY.toInt() ?? 1,
                  onChanged: (value) =>
                      widget.onChangeCustomRatio(CropAspectRatio(
                    ratioX: widget.aspectRatio?.ratioX ?? 1,
                    ratioY: value.toDouble(),
                  )),
                  label: 'RatioY',
                )
              ],
      ],
    );
  }
}
