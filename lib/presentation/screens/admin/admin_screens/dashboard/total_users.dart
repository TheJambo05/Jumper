import 'package:flutter/material.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/user/user_model.dart';

class TotalUsers extends StatelessWidget {
  final List<UserModel> users;

  const TotalUsers({Key? key, required this.users}) : super(key: key);

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
          'Total Users: ${users.length}',
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
