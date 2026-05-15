import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/model/food_item.dart';
import 'package:smartcanteen/provider/menu_provider.dart';

class AdminAddItemScreen extends StatefulWidget {
  const AdminAddItemScreen({super.key});

  @override
  State<AdminAddItemScreen> createState() => _AdminAddItemScreenState();
}

class _AdminAddItemScreenState extends State<AdminAddItemScreen> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();

  void addItem() {
    String name = nameController.text.trim();
    double? price = double.tryParse(priceController.text);
    String category = categoryController.text.trim();
    String image = imageController.text.trim();

    if (name.isEmpty || price == null || category.isEmpty || image.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid data")),
      );
      return;
    }

    final newItem = FoodItem(
      name: name,
      price: price,
      category: category,
      image: image,
      available: true,
    );

    context.read<MenuProvider>().addItem(newItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item Added Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Menu Item"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Food Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category (Snacks / Meals / Drinks)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
TextField(
  controller: imageController,
  decoration: const InputDecoration(
    labelText: "https://images.unsplash.com/photo-1553530666-ba11a90caa2d",
    border: OutlineInputBorder(),
  ),
),


            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: addItem,
              child: const Text("Add Item"),
            )
          ],
        ),
      ),
    );
  }
}
