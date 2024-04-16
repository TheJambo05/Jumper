import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/admin/admin_panel.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/dash_board.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/products/products.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/users.dart';
import 'package:jumper/presentation/screens/home/category_screen.dart';
import 'package:jumper/presentation/screens/home/profile_screen.dart';
import 'package:jumper/presentation/screens/vendors/add_products_screen.dart';
import 'package:jumper/presentation/screens/vendors/providers/add_products_provider.dart';
import 'package:provider/provider.dart';
import '../data/models/category/category_model.dart';
import '../data/models/product/product_model.dart';
import '../logic/cubits/category_product_cubit/category_product_cubit.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/providers/login_provider.dart';
import '../presentation/screens/auth/providers/signup_provider.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/cart/cart_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/order/my_order_screen.dart';
import '../presentation/screens/order/order_detail_screen.dart';
import '../presentation/screens/order/order_placed_screen.dart';
import '../presentation/screens/order/providers/order_detail_provider.dart';
import '../presentation/screens/product/category_product_screen.dart';
import '../presentation/screens/product/product_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/user/edit_profile_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));

      case SignupScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen()));

      ////////////////Vendors//////////////
      case AddProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AddProductProvider(context),
                child: const AddProductScreen()));

      ///////////////Admin/////////////////
      case AdminPanel.routeName:
        return CupertinoPageRoute(builder: (context) => const AdminPanel());

      case Users.routeName:
        return CupertinoPageRoute(builder: (context) => const Users());

      case Products.routeName:
        return CupertinoPageRoute(builder: (context) => const Products());

      case Dashboard.routeName:
        return CupertinoPageRoute(builder: (context) => const Dashboard());
      ///////////////User//////////////////
      case HomeScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AddProductProvider(context),
                child: const HomeScreen()));

      case Extra.routeName:
        return CupertinoPageRoute(builder: (context) => Extra());

      case ProfileScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const ProfileScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productModel: settings.arguments as ProductModel,
                ));

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CategoryProductCubit(settings.arguments as CategoryModel),
                child: const CategoryProductScreen()));

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const EditProfileScreen());

      // case ChangePasswordScreen.routeName:
      //   return CupertinoPageRoute(
      //       builder: (context) => const ChangePasswordScreen());

      // case ChangePasswordScreen.routeName:
      //   return CupertinoPageRoute(
      //       builder: (context) => ChangeNotifierProvider(
      //           create: (context) => PasswordProvider(context),
      //           child: const ChangePasswordScreen()));

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderDetailProvider(),
                child: const OrderDetailScreen()));

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case MyOrderScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const MyOrderScreen());

      default:
        return null;
    }
  }
}
