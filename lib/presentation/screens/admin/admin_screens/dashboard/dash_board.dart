import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_cubit.dart';
import 'package:jumper/logic/cubits/admin_cubits/user_cubit/user_list_state.dart';
import 'package:jumper/logic/cubits/order_cubit/order_cubit.dart';
import 'package:jumper/logic/cubits/order_cubit/order_state.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubit.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/top_users.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/total_orders.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/total_products.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/dashboard/total_users.dart';
import 'package:jumper/presentation/screens/admin/admin_screens/user/users.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const routeName = "dash_board";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                SizedBox(
                    height: 45,
                    width: 350,
                    child: PrimaryTextField(labelText: "Search")),
                GapWidget(),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/CV.jpg'),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<UserListCubit, UserListState>(
                            builder: (context, state) {
                              if (state is UserListLoadingState &&
                                  state.users.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is UserListErrorState &&
                                  state.users.isEmpty) {
                                return Center(child: Text(state.message));
                              }

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Users.routeName);
                                  },
                                  child: TotalUsers(users: state.users));
                            },
                          ),
                          const GapWidget(),
                          BlocBuilder<UserListCubit, UserListState>(
                            builder: (context, state) {
                              if (state is UserListLoadingState &&
                                  state.users.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is UserListErrorState &&
                                  state.users.isEmpty) {
                                return Center(child: Text(state.message));
                              }

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Users.routeName);
                                  },
                                  child: TotalUsers(users: state.users));
                            },
                          ),
                        ],
                      ),
                      const GapWidget(),
                      Row(
                        children: [
                          BlocBuilder<OrderCubit, OrderState>(
                            builder: (context, state) {
                              if (state is OrderLoadingState &&
                                  state.orders.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is OrderErrorState &&
                                  state.orders.isEmpty) {
                                return Center(child: Text(state.message));
                              }

                              return GestureDetector(
                                  onTap: () {
                                    ////////
                                  },
                                  child: TotalOrders(orders: state.orders));
                            },
                          ),
                          const GapWidget(),
                          BlocBuilder<OrderCubit, OrderState>(
                            builder: (context, state) {
                              if (state is OrderLoadingState &&
                                  state.orders.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is OrderErrorState &&
                                  state.orders.isEmpty) {
                                return Center(child: Text(state.message));
                              }

                              return GestureDetector(
                                  onTap: () {
                                    ////////
                                  },
                                  child: TotalOrders(orders: state.orders));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoadingState &&
                          state.products.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is ProductErrorState &&
                          state.products.isEmpty) {
                        return Center(child: Text(state.message));
                      }

                      return GestureDetector(
                          onTap: () {
                            /////////
                          },
                          child: Expanded(
                              child: TotalProducts(products: state.products)));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 50),
              BlocBuilder<UserListCubit, UserListState>(
                builder: (context, state) {
                  if (state is UserListLoadingState && state.users.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is UserListErrorState && state.users.isEmpty) {
                    return Center(child: Text(state.message));
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white1,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 4, // Blur radius
                          offset: const Offset(0, 2), // Shadow offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recently Added Users',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const GapWidget(),
                              Row(
                                children: [
                                  Expanded(child: TopUsers(users: state.users)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
