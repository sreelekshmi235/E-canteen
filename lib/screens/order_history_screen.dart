import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case "Preparing":
        return Colors.orange;
      case "Ready":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {
    var orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        leading: const BackButton(),
      ),

      body: orders.isEmpty
          ? const Center(child: Text("No Orders Yet"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, i) {

                final order = orders[i];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Order ${i + 1}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Items: ${order.items.map((e) => e.name).join(", ")}",
                        ),

                        Text("Total: ₹${order.total}"),

                        const Divider(),

                        Text("Name: ${order.name}"),
                        Text("Block: ${order.block}"),
                        Text("Room: ${order.room}"),
                        const Divider(),

                        Text(
                          "Time: ${order.dateTime.hour}:${order.dateTime.minute.
                          toString().padLeft(2, '0')}",
                        ),

                        Text(
                          "Date: ${order.dateTime.day
                          }/${order.dateTime.month}/${order.dateTime.year}",
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: getStatusColor(order.status)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order.status,
                            style: TextStyle(
                              color: getStatusColor(order.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}