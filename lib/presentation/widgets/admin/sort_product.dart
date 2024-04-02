import 'package:flutter/material.dart';
import 'package:jumper/data/models/product/product_model.dart';

class SortProduct extends StatelessWidget {
  final List<ProductModel> products;

  const SortProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Sort by'),
      onChanged: (value) {},
      items: <String>['Title', 'Price', 'Date'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
