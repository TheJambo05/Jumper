import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/widgets/user/product_page.dart';
import '../../../../logic/cubits/product_cubit/product_state.dart';
import '../../../logic/cubits/product_cubit/product_cubit.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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

          return ProductPage(products: state.products);
        },
      ),
    );
  }
}
