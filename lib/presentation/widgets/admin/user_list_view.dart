import 'package:flutter/material.dart';
import '../../../data/models/user/user_model.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> users;
  final bool shrinkWrap;
  final bool noScroll;

  const UserListView(
      {Key? key,
      required this.users,
      this.shrinkWrap = false,
      this.noScroll = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: shrinkWrap,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            title: Text("${user.fullName}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text(
                              "Are you sure you want to remove this item from your cart?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Remove the item from the cart
                                // BlocProvider.of<UserListCubit>(context)
                                //     .removeFromCart(item.product!);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
