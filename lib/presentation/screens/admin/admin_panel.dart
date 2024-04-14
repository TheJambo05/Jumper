import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/dash_board.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/orders/orders.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/products/products.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/users.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  static const String routeName = "admin_panel";

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    Dashboard(),
    Users(),
    Products(),
    Orders(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Container(
              width: 200,
              color: Colors.black,
              child: ListView(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Jumper",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                  _buildListItem(0, 'Dashboard'),
                  _buildListItem(1, 'Users'),
                  _buildListItem(2, 'Products'),
                  _buildListItem(3, 'Orders'),
                ],
              ),
            ),
            Expanded(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index, String title) {
    return Container(
      color: _selectedIndex == index ? Colors.white : Colors.transparent,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.black : Colors.white,
            fontWeight:
                _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          _selectScreen(index);
        },
      ),
    );
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
