// import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:jumper/presentation/screens/admin/admin_screens/orders.dart';
// import 'package:jumper/presentation/screens/admin/admin_screens/products.dart';
// import 'package:jumper/presentation/screens/admin/admin_screens/users.dart';
// import '../home/profile_screen.dart';

// class AdminPanel extends StatefulWidget {
//   const AdminPanel({Key? key}) : super(key: key);

//   static const String routeName = "admin_panel";

//   @override
//   State<AdminPanel> createState() => _AdminPanelState();
// }

// class _AdminPanelState extends State<AdminPanel> {
//   int currentIndex = 0;
//   List<Widget> screens = const [Users(), Products(), Orders(), ProfileScreen()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Jumper",
//             ),
//           ],
//         ),
//       ),
//       body: screens[currentIndex],
//       bottomNavigationBar: FloatingNavbar(
//         items: [
//           FloatingNavbarItem(icon: Icons.home, title: 'Home'),
//           FloatingNavbarItem(icon: Icons.shopping_bag, title: 'Products'),
//           FloatingNavbarItem(icon: Icons.shopping_cart, title: 'Orders'),
//           FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
//           // FloatingNavbarItem(
//           //     icon: Icons.admin_panel_settings, title: 'Admin'),
//         ],
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
