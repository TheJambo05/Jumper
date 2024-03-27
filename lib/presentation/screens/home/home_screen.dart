import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/home/category_screen.dart';
import 'package:jumper/presentation/screens/home/product_screen.dart';
import 'package:jumper/presentation/screens/home/profile_screen.dart';
import 'package:jumper/presentation/screens/home/user_feed_screen.dart';
import 'package:jumper/presentation/widgets/side_drawer.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../cart/cart_screen.dart';
import '../splash/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    ProductScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Jumper",
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon:
                BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              return Badge(
                  label: Text("${state.items.length}"),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child: const Icon(CupertinoIcons.cart_fill));
            })),
          ],
        ),
        drawer: const SideDrawer(),
        body: screens[currentIndex],
        bottomNavigationBar: FloatingNavbar(
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.shopping_bag, title: 'Products'),
            FloatingNavbarItem(icon: Icons.shopping_cart, title: 'Orders'),
            FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
            // FloatingNavbarItem(
            //     icon: Icons.admin_panel_settings, title: 'Admin'),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
