import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Admin Dashboard!',
            style: TextStyle(fontSize: 24),
          ),
          // Add more widgets for your dashboard here
        ],
      ),
    );
  }
}
