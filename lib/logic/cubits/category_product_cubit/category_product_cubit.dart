import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/category_product_cubit/category_product_state.dart';
import '../../../data/models/category/category_model.dart';
import '../../../data/repositories/product_repository.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(CategoryProductLoadingState(state.products));
    try {
      final products =
          await _productRepository.fetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(ex.toString(), state.products));
    }
  }
}
