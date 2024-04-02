import 'package:flutter/material.dart';
import 'package:jumper/data/models/user/user_model.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/user_profile.dart';

class UserListView extends StatefulWidget {
  final List<UserModel> users;

  const UserListView({Key? key, required this.users}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late List<UserModel> filteredUsers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    // Sort the users alphabetically by full name
    _sortUsers();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                labelText: 'Search by name, email, or phone number',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filteredUsers = widget.users
                      .where((user) =>
                          user.fullName != null &&
                          user.email != null &&
                          user.phoneNumber != null &&
                          (user.fullName!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              user.email!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              user.phoneNumber!
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                      .toList();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DataTable(
                  dataRowMinHeight: 0, // Remove the dividers between rows
                  dataRowMaxHeight: 90,
                  headingTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  dataTextStyle: const TextStyle(color: Colors.black),
                  columns: const [
                    DataColumn(label: Text('Profile')),
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone Number')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Register On')),
                    DataColumn(label: Text('Type')),
                  ],
                  rows: filteredUsers.map((user) {
                    return DataRow(
                      cells: [
                        const DataCell(
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/CV.jpg"),
                          ),
                        ),
                        DataCell(Text(user.fullName ?? "")),
                        DataCell(Text(user.email ?? "")),
                        DataCell(Text(user.phoneNumber ?? "")),
                        DataCell(Text(user.address ?? "")),
                        DataCell(Text(user.createdOn ?? "")),
                        const DataCell(Text("Okey")),
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Function to sort users alphabetically by full name
  void _sortUsers() {
    filteredUsers
        .sort((a, b) => (a.fullName ?? "").compareTo(b.fullName ?? ""));
  }
}
