import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_state.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:jumper/presentation/screens/cart/cart_screen.dart';
import 'package:jumper/presentation/screens/home/category_screen.dart';
import 'package:jumper/presentation/screens/home/product_screen.dart';
import 'package:jumper/presentation/screens/home/profile_screen.dart';
import 'package:jumper/presentation/screens/home/user_feed_screen.dart';
import 'package:jumper/presentation/screens/splash/splash_screen.dart';
import 'package:jumper/presentation/screens/vendors/add_products_screen.dart';
import 'package:jumper/presentation/widgets/user/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    AddProductScreen(),
    // Extra(),
    // UserFeedScreen(),
    ProductScreen(),
    ProfileScreen(),
    // AddProductScreen()
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
              SizedBox(
                child: Text("Jumper"),
                // height: 80,
                // width: 100,
                // child: Image(
                //   image: AssetImage("assets/Jumper.png"),
                // ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Badge(
                    label: Text("${state.items.length}"),
                    isLabelVisible: state is! CartLoadingState,
                    child: const Icon(CupertinoIcons.cart_fill),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: const SideDrawer(),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
