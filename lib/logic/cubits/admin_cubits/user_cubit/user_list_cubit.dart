// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_state.dart';
// import '../../../../data/repositories/user_repository.dart';

// class UserListCubit extends Cubit<UserListState> {
//   UserListCubit() : super(UserListInitialState()) {
//     _initialize();
//   }

//   final _userRepository = UserRepository();

//   void _initialize() async {
//     emit(UserListLoadingState(state.users));
//     try {
//       final products = await _userRepository.fetchAllUsers();
//       emit(UserListLoadedState(products));
//     } catch (ex) {
//       emit(UserListErrorState(ex.toString(), state.users));
//     }
//   }
// }
