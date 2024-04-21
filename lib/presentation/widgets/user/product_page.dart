import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumper/core/api.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/services/formatter.dart';
import 'package:jumper/presentation/screens/product/product_screen.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

class ProductPage extends StatefulWidget {
  final List<ProductModel> products;

  const ProductPage({Key? key, required this.products}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedCategory = 'All'; // Default selected category

  List<ProductModel> get sortedProducts {
    // Filter products based on the selected category
    if (_selectedCategory == 'All') {
      return widget.products;
    } else {
      return widget.products
          .where((product) => product.category == _selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          // Dropdown button for selecting category
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Sort by: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const GapWidget(),
              DropdownButton<String>(
                value: _selectedCategory,
                items: ['All', 'Mens', 'Womens', 'Unisex']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: sortedProducts.length,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                final product = sortedProducts[index];

                return CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailsScreen.routeName,
                      arguments: product,
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: product.images != null &&
                                    product.images!.isNotEmpty
                                ? "$finalUrl${product.images}"
                                : 'http://placehold.it/200x200',
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title ?? 'Product Title',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                Formatter.formatPrice(product.price!),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
