import 'package:flutter/material.dart';

class PrimaryDropdownField extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const PrimaryDropdownField({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items,
    );
  }
}
