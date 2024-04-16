import 'package:flutter/material.dart';

class PrimaryDropdownField extends StatefulWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const PrimaryDropdownField({
    Key? key,
    required this.labelText,
    this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PrimaryDropdownFieldState createState() => _PrimaryDropdownFieldState();
}

class _PrimaryDropdownFieldState extends State<PrimaryDropdownField> {
  String? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      value: currentValue,
      onChanged: (String? newValue) {
        setState(() {
          currentValue = newValue;
        });
        widget.onChanged(newValue);
      },
      items: widget.items,
    );
  }
}
