import '../../../../data/models/user/user_model.dart';

abstract class UserListState {
  final List<UserModel> users;
  UserListState(this.users);
}

class UserListInitialState extends UserListState {
  UserListInitialState() : super([]);
}

class UserListLoadingState extends UserListState {
  UserListLoadingState(super.users);
}

class UserListLoadedState extends UserListState {
  UserListLoadedState(super.users);
}

class UserListErrorState extends UserListState {
  final String message;
  UserListErrorState(this.message, super.users);
}
