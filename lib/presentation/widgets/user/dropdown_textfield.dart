import 'package:flutter/material.dart';
import 'package:jumper/data/models/category/category_model.dart';

class DropDownTextField extends StatefulWidget {
  final String labelText;
  final List<CategoryModel> categories;
  final String? selectedDropdownItem;
  final void Function(String?)? onDropdownChanged;

  const DropDownTextField({
    Key? key,
    required this.labelText,
    required this.categories,
    this.selectedDropdownItem,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  _DropDownTextFieldState createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController(text: _selectedItem),
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          DropdownButton<String>(
            value: _selectedItem,
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
                widget.onDropdownChanged?.call(newValue);
              });
            },
            items: widget.categories.map((CategoryModel category) {
              return DropdownMenuItem<String>(
                value: category.title,
                child: Text(category.title!),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
