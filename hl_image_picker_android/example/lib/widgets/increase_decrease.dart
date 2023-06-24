import 'package:flutter/material.dart';

class IncreaseAndDecrease extends StatelessWidget {
  const IncreaseAndDecrease(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.label});

  final String label;
  final int value;
  final Function(int value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          const SizedBox(width: 16),
          Row(
            children: [
              Material(
                color: value == 1 ? Colors.grey[300] : Colors.blue,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: value == 1 ? null : () => onChanged(value - 1),
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: const Text(
                      '-',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 40,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                  )),
              Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: () => onChanged(value + 1),
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: const Text(
                      '+',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
