import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import '../../../data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void addProduct({
    required String title,
    required String category,
    required String description,
    required String price,
    File? imageFile,
  }) async {
    emit(ProductLoadingState(state.products));

    try {
      ProductModel productModel = await _productRepository.addProduct(
        title: title,
        category: category,
        description: description,
        price: price,
      );
      List<ProductModel> updatedProducts = List.from(state.products)
        ..add(productModel);
      emit(ProductLoadedState(updatedProducts));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }

  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      final products = await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
