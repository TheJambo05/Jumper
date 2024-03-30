import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/user/user_model.dart';
import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_cubit.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> users;

  const UserListView({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            onTap: () {
              // Handle user profile view or edit here
              // Navigator.pushNamed(context, UserProfileScreen.routeName,
              //     arguments: user);
            },
            title: Container(
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${user.fullName}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Handle user deletion
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete User'),
                          content: Text(
                              'Are you sure you want to delete ${user.fullName}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<UserListCubit>(context)
                                    .removeUser(user.sId!);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
