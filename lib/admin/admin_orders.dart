import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Orders"),
        leading: const BackButton(),
      ),
      body: orderProvider.orders.isEmpty
          ? const Center(child: Text("No Orders Yet"))
          : ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (_, i) {
                final order = orderProvider.orders[i];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Order ${i + 1}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Items: ${order.items.map((e) => e.name).join(", ")}"),
                        Text("Total: ₹${order.total}"),
                        Text("Status: ${order.status}"),
                      ],
                    ),
                    trailing:DropdownButton<String>(
  value: order.status,
  items: const [
    DropdownMenuItem(value: "Pending", child: Text("Pending")),
    DropdownMenuItem(value: "Preparing", child: Text("Preparing")),
    DropdownMenuItem(value: "Ready", child: Text("Ready")),
    DropdownMenuItem(value: "Delivered", child: Text("Delivered")),
  ],
  onChanged: (newStatus) {
    order.status = newStatus!;
    context.read<OrderProvider>().notifyListeners();
  },
),

                  ),
                );
              },
            ),
    );
  }
}
