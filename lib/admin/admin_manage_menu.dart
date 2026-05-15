import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/model/food_item.dart';
import 'package:smartcanteen/provider/menu_provider.dart';

class AdminManageMenuScreen extends StatelessWidget {
  const AdminManageMenuScreen({super.key});

  void editItem(BuildContext context, FoodItem item) {
    TextEditingController name = TextEditingController(text: item.name);
    TextEditingController price =
        TextEditingController(text: item.price.toString());
    TextEditingController category =
        TextEditingController(text: item.category);
    TextEditingController image =
        TextEditingController(text: item.image);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Item"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: category,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: image,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              item.name = name.text;
              item.price = double.tryParse(price.text) ?? item.price;
              item.category = category.text;
              item.image = image.text;

              context.read<MenuProvider>().notifyListeners();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>().menu;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Manage Menu"),
        centerTitle: true,
        elevation: 0,
      ),
      body: menu.isEmpty
          ? const Center(
              child: Text(
                "No menu items available",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: menu.length,
              itemBuilder: (_, i) {
                final item = menu[i];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// FOOD IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.fastfood,
                                  size: 35,
                                  color: Colors.black54,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// DETAILS + ACTIONS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${item.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Category: ${item.category}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),

                              /// RESPONSIVE ACTION SECTION
                              Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Available",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Switch(
                                        value: item.available,
                                        onChanged: (val) {
                                          item.available = val;
                                          context
                                              .read<MenuProvider>()
                                              .notifyListeners();
                                        },
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: "Edit",
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () =>
                                            editItem(context, item),
                                      ),
                                      IconButton(
                                        tooltip: "Delete",
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title:
                                                  const Text("Delete Item"),
                                              content: Text(
                                                "Are you sure you want to delete '${item.name}'?",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<MenuProvider>()
                                                        .deleteItem(i);
                                                    Navigator.pop(context);
                                                  },
                                                  child:
                                                      const Text("Delete"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
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