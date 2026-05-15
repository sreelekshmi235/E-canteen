import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';
import 'package:smartcanteen/screens/order_detail_screen.dart';
import 'package:smartcanteen/screens/order_history_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        leading: const BackButton(),
      ),
      body: orderProvider.cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orderProvider.cart.length,
                    itemBuilder: (_, i) {
                      final item = orderProvider.cart[i];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text("₹${item.price}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            orderProvider.cart.removeAt(i);
                            orderProvider.notifyListeners();
                          },
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: ₹${orderProvider.cart.fold(0.0, (sum, item) => sum + item.price)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),

                    ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrange,
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OrderDetailsScreen(),
      ),
    );
  },
  child: const Text("Proceed to Delivery Details"),
),

                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
