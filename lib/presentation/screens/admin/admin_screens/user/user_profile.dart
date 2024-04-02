import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/user/user_model.dart';
import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_cubit.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel user;

  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName ?? 'User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit user profile page
              // You can implement this based on your requirements
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context, user);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/CV.jpg"),
                radius: 70,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'User Profile Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            _buildDetailRow('Username', user.fullName ?? ''),
            _buildDetailRow('Email', user.email ?? ''),
            _buildDetailRow('Phone Number', user.phoneNumber ?? ''),
            _buildDetailRow('Address', user.address ?? ''),
            _buildDetailRow('Register On', user.createdOn ?? ''),
            _buildDetailRow('Type', 'Admin'),
            const SizedBox(height: 20),
            const Text(
              'User Profile Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete ${user.fullName}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<UserListCubit>(context).removeUser(user.sId!);
              Navigator.pop(context);
              // Show snackbar after the user is deleted
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${user.fullName} removed from user.'),
                  duration: const Duration(seconds: 2),
                ),
              );
              // Optionally, navigate back to the previous screen after deleting the user
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
