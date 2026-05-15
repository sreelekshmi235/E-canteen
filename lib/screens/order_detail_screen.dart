import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  final blockController = TextEditingController();
  final roomController = TextEditingController();
  final nameController = TextEditingController();

  void confirmOrder() {

    if(blockController.text.isEmpty ||
       roomController.text.isEmpty ||
       nameController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all details")),
      );
      return;
    }

    context.read<OrderProvider>().placeOrder(
      blockController.text,
      roomController.text,
      nameController.text,
    );

    Navigator.pop(context);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Placed Successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Details"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: blockController,
              decoration: const InputDecoration(
                labelText: "Block / Department",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                labelText: "Room / Cabin No",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: confirmOrder,
              child: const Text("Confirm Order"),
            )
          ],
        ),
      ),
    );
  }
}
