import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/menu_provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';
import 'package:smartcanteen/screens/cart.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  String selectedCategory = "Snacks";

  final categories = ["Snacks", "Meals", "Drinks"];

  @override
  Widget build(BuildContext context) {
    var menuProvider = context.watch<MenuProvider>();
    var orderProvider = context.read<OrderProvider>();

    var filtered = menuProvider.menu
        .where((item) => item.category == selectedCategory && item.available)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Menu"),
        leading: const BackButton(),
      ),

      body: Column(
        children: [

          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedCategory = categories[i]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[i]
                          ? Colors.deepOrange
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categories[i],
                      style: TextStyle(
                        color: selectedCategory == categories[i]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) {
                final item = filtered[i];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
  item.image,
  fit: BoxFit.cover,
  width: double.infinity,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.fastfood, size: 40);
  },
)

                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),

                      Text("₹${item.price}",
                          style: const TextStyle(color: Colors.deepOrange)),

                      ElevatedButton(
                        onPressed: () {
                          orderProvider.addToCart(item);
                        },
                        child: const Text("Add"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
        label: const Text("Cart"),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
