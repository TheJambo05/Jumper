import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/user_list_view.dart';
import '../../../../../logic/cubits/admin_cubits/user_cubit/user_list_cubit.dart';
import '../../../../../logic/cubits/admin_cubits/user_cubit/user_list_state.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  static const routeName = "users";

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListLoadingState && state.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserListErrorState && state.users.isEmpty) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state.users.isEmpty) {
            return const Center(
              child: Text(
                'No users found.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: UserListView(users: state.users),
          );
        },
      ),
    );
  }
}
