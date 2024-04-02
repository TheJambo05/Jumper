import 'package:flutter/material.dart';

class RecentlyAddedProducts extends StatelessWidget {
  const RecentlyAddedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recently Added Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(
                children: [
                  TableCell(child: Text('Product Name')),
                  TableCell(child: Text('Price')),
                  TableCell(child: Text('Quantity')),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Text('Product 1')),
                  TableCell(child: Text('\$10')),
                  TableCell(child: Text('5')),
                ],
              ),
              TableRow(
                children: [
                  TableCell(child: Text('Product 2')),
                  TableCell(child: Text('\$20')),
                  TableCell(child: Text('3')),
                ],
              ),
              // Add more rows as needed
            ],
          ),
        ],
      ),
    );
  }
}
