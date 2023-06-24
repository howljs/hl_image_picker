import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {super.key, required this.label, required this.value, this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          const SizedBox(width: 16),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
