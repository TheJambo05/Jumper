import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumper/core/api.dart';
import '../../../data/models/product/product_model.dart';
import '../../../logic/services/formatter.dart';
import '../../screens/product/product_screen.dart';

class ProductPage extends StatelessWidget {
  final List<ProductModel> products;

  const ProductPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
        // Removed the childAspectRatio to allow images to define their own height
      ),
      itemCount: products.length,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        final product = products[index];

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
                  aspectRatio: 1, // Square aspect ratio for the image
                  child: CachedNetworkImage(
                    imageUrl: product.images != null &&
                            product.images!.isNotEmpty
                        ? "$finalUrl${product.images}"
                        : 'http://placehold.it/200x200', // Placeholder image
                    width: MediaQuery.of(context).size.width / 2,
                    fit: BoxFit.contain, // Changed to BoxFit.contain
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
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
    );
  }
}
