import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubit.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';

class TotalProducts extends StatelessWidget {
  final List<ProductModel> products;

  const TotalProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.62,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.white1,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 4, // Blur radius
              offset: const Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Total Products: ${products.length}',
            textAlign: TextAlign.center, // Align text to center
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    });
  }
}
