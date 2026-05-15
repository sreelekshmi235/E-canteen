import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';

class SalesDashboard extends StatelessWidget {
  const SalesDashboard({super.key});

  @override
Widget build(BuildContext context) {
  var provider = context.watch<OrderProvider>();

  return Scaffold(
    appBar: AppBar(title: const Text("Sales Dashboard")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Total Revenue: ₹${provider.totalRevenue}",
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Text(
            "Most Sold Item: ${provider.mostSoldItem}",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
}
