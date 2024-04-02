import '../../../../data/models/product/product_model.dart';

abstract class UserProductState {
  final List<ProductModel> products;
  UserProductState(this.products);
}

class UserProductInitialState extends UserProductState {
  UserProductInitialState() : super([]);
}

class UserProductLoadingState extends UserProductState {
  UserProductLoadingState(super.products);
}

class UserProductLoadedState extends UserProductState {
  UserProductLoadedState(super.products);
}

class UserProductErrorState extends UserProductState {
  final String message;
  UserProductErrorState(this.message, super.products);
}
