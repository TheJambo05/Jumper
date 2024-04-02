import 'package:flutter/material.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/order/order_model.dart';

class TotalOrders extends StatelessWidget {
  final List<OrderModel> orders;

  const TotalOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(8.0),
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
      child: Center(
        child: Text(
          'Total Orders: ${orders.length}',
          textAlign: TextAlign.center, // Align text to center
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
