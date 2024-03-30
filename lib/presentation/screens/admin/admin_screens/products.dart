import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  static const String routeName = "products";

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
    );
  }
}
