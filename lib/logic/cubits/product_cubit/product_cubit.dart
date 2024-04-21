import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/product/product_model.dart';
import 'package:jumper/data/repositories/product_repository.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart'; // Import UserCubit if not already imported
import '../../../logic/cubits/user_cubit/user_state.dart'; // Import UserLoggedInState if not already imported

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();
  final _userCubit =
      UserCubit(); // Initialize UserCubit if not already initialized

  void addProduct({
    required String title,
    required String category,
    required String description,
    required String price,
    File? imageFile,
  }) async {
    emit(ProductLoadingState(state.products));

    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        ProductModel productModel = await _productRepository.addProduct(
          title: title,
          category: category,
          description: description,
          price: price,
          images: imageFile,
          userId: userState.userModel.sId!, // Fix typo here
        );
        List<ProductModel> updatedProducts = List.from(state.products)
          ..add(productModel);
        emit(ProductLoadedState(updatedProducts));
      }
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
