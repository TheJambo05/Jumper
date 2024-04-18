import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_state.dart';
import 'package:provider/provider.dart';
import 'package:jumper/presentation/screens/order/order_placed_screen.dart';
import 'package:jumper/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:jumper/presentation/widgets/user/cart_list_view.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:jumper/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:jumper/logic/cubits/order_cubit/order_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/order-detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  void _showPaymentError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _createOrder(BuildContext context) async {
    final success = await BlocProvider.of<OrderCubit>(context).createOrder(
      items: BlocProvider.of<CartCubit>(context).state.items,
      paymentMethod: Provider.of<OrderDetailProvider>(context, listen: false)
          .paymentMethod
          .toString(),
    );
    if (success == true || success == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushNamed(context, OrderPlacedScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderDetailProvider>(context);

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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${state.userModel.fullName}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Email: ${state.userModel.email}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Phone: ${state.userModel.phoneNumber}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Address: ${state.userModel.address}, ${state.userModel.city}",
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
              RadioListTile(
                value: "pay-on-delivery",
                groupValue: orderProvider.paymentMethod,
                onChanged: (String? value) {
                  orderProvider.changePaymentMethod(value);
                },
                title: const Text("Pay on Delivery"),
              ),
              RadioListTile(
                value: "pay-now",
                groupValue: orderProvider.paymentMethod,
                onChanged: (String? value) {
                  orderProvider.changePaymentMethod(value);
                },
                title: const Text("Pay Now"),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: () async {
                  if (orderProvider.paymentMethod == "pay-now") {
                    // Initiate Khalti payment
                    final config = PaymentConfig(
                      amount: 10, // Will be Replaced with the actual amount
                      productIdentity: 'your-product-id',
                      productName: 'Product Name',
                    );

                    KhaltiScope.of(context).pay(
                      config: config,
                      onSuccess: (success) {
                        // Handle successful payment and place the order
                        _createOrder(context);
                      },
                      onFailure: (error) {
                        // Handle payment failure
                        _showPaymentError(context, error.message);
                      },
                      onCancel: () {
                        // Handle payment cancellation
                        print("Payment Cancelled");
                      },
                    );
                  } else {
                    // If payment method is not 'pay-now', proceed with order creation
                    _createOrder(context);
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
