import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:jumper/presentation/screens/order/order_placed_screen.dart';
import 'package:jumper/presentation/screens/order/providers/order_detail_provider.dart';
import '../../../core/design.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/user/cart_list_view.dart';
import '../../widgets/user/gap_widget.dart';
import '../../widgets/user/primary_button.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const routeName = "order_detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "User Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  if (state is UserLoggedInState) {
                    UserModel user = state.userModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${user.fullName}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Email: ${user.email}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Phone: ${user.phoneNumber}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Address: ${user.address}, ${user.city}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }

                  if (state is UserErrorState) {
                    return Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                    );
                  }

                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoadingState && state.items.isEmpty) {
                      return const CircularProgressIndicator();
                    }

                    if (state is CartErrorState && state.items.isEmpty) {
                      return Text(
                        state.message,
                        style: const TextStyle(fontSize: 16),
                      );
                    }

                    return CartListView(
                      items: state.items,
                      shrinkWrap: true,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Payment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Consumer<OrderDetailProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile(
                        value: "pay-on-delivery",
                        groupValue: provider.paymentMethod,
                        onChanged: provider.changePaymentMethod,
                        title: const Text("Pay on Delivery"),
                      ),
                      RadioListTile(
                        value: "pay-now",
                        groupValue: provider.paymentMethod,
                        onChanged: provider.changePaymentMethod,
                        title: const Text("Pay Now"),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: () async {
                  bool? success =
                      await BlocProvider.of<OrderCubit>(context).createOrder(
                    items: BlocProvider.of<CartCubit>(context).state.items,
                    paymentMethod:
                        Provider.of<OrderDetailProvider>(context, listen: false)
                            .paymentMethod
                            .toString(),
                  );
                  if (success == null) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                  }
                  if (success == true) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                  }
                },
                text: "Place Order",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
