import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubit.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import 'package:jumper/presentation/widgets/admin/fetch_products_by_admin.dart';

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
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState && state.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductErrorState && state.products.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }

          return AdminProductPage(products: state.products);
        },
      ),
    );
  }
}
