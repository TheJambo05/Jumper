// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jumper/data/models/user/user_model.dart';
// import 'package:jumper/data/repositories/product_repository.dart';
// import 'package:jumper/logic/cubits/admin_cubits/product_cubit/user_product_state.dart';

// class UserProductCubit extends Cubit<UserProductState> {
//   final UserModel user;
//   UserProductCubit(this.user) : super(UserProductInitialState()) {
//     _initialize();
//   }

//   final _productRepository = ProductRepository();

//   void _initialize() async {
//     emit(UserProductLoadingState(state.products));
//     try {
//       final products = await _productRepository.fetchProductsById(user.sId!);
//       emit(UserProductLoadedState(products));
//     } catch (ex) {
//       emit(UserProductErrorState(ex.toString(), state.products));
//     }
//   }
// }
