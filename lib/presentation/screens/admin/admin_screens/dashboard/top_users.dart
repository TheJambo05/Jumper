import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/user/user_model.dart';
import 'package:jumper/logic/services/formatter.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/user_profile.dart';

class TopUsers extends StatefulWidget {
  final List<UserModel> users;

  const TopUsers({Key? key, required this.users}) : super(key: key);

  @override
  State<TopUsers> createState() => _TopUsersState();
}

class _TopUsersState extends State<TopUsers> {
  late List<UserModel> filteredUsers;

  @override
  void initState() {
    super.initState();
    filteredUsers = _getTopUsers(widget.users);
  }

  List<UserModel> _getTopUsers(List<UserModel> users) {
    // Sort users by creation date in descending order
    users.sort((a, b) => b.createdOn!.compareTo(a.createdOn!));
    // Take only the top 5 users
    return users.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      // dataRowMinHeight: 0, // Remove the dividers between rows
      dataRowMaxHeight: 100,
      headingTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      dataTextStyle: const TextStyle(color: Colors.black),
      columns: const [
        DataColumn(label: Text('Profile')),
        DataColumn(label: Text('Username')),
        DataColumn(label: Text('Phone Number')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Register On')),
      ],
      rows: filteredUsers.map((user) {
        return DataRow(
          cells: [
            const DataCell(
              CircleAvatar(
                backgroundImage: AssetImage("assets/CV.jpg"),
              ),
            ),
            DataCell(Text(
              user.fullName ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
            DataCell(Text(
              user.phoneNumber ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
            DataCell(Text(
              user.address ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
            DataCell(Text(
              Formatter.formatDateAndTime(user.createdOn!),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
          ],
          // Make the row clickable
          onSelectChanged: (_) {
            // Handle what happens when the row is clicked
            // For example, navigate to the user profile page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(user: user),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
