import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_state.dart';
import '../../../../data/repositories/user_repository.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(UserListInitialState()) {
    _initialize();
  }

  final _userRepository = UserRepository();

  void removeUser(String userId) async {
    emit(UserListLoadingState(state.users));
    try {
      await _userRepository.removeUser(userId);
      // Fetch updated user list after removal
      final updatedUsers = await _userRepository.fetchAllUsers();
      emit(UserListLoadedState(updatedUsers));
    } catch (ex) {
      emit(UserListErrorState(ex.toString(), state.users));
    }
  }

  void _initialize() async {
    emit(UserListLoadingState(state.users));
    try {
      final users = await _userRepository.fetchAllUsers();
      emit(UserListLoadedState(users));
    } catch (ex) {
      emit(UserListErrorState(ex.toString(), state.users));
    }
  }
}
