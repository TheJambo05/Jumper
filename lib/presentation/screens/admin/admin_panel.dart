import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/orders.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/products.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/users.dart';
import '../home/profile_screen.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  static const String routeName = "admin_panel";

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [Users(), Products(), Orders()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Container(
              width: 200,
              color: Colors.blueGrey,
              child: ListView(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Jumper",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  _buildListItem(0, 'Users'),
                  _buildListItem(1, 'Products'),
                  _buildListItem(2, 'Orders'),
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
      color:
          _selectedIndex == index ? Colors.blueGrey[200] : Colors.transparent,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black87,
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
