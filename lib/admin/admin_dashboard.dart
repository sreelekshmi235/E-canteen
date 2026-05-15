import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order_provider.dart';
import 'admin_add_item.dart';
import 'admin_manage_menu.dart';
import 'admin_orders.dart';
import 'sales_dashboard.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Widget dashboardCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.deepOrange,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(blurRadius: 5, color: Colors.black12)
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var orders = context.watch<OrderProvider>().orders;

    double revenue = orders.fold(0,
        (sum, order) => sum + order.total);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: statCard(
                    "Orders",
                    orders.length.toString(),
                    Icons.receipt_long,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: statCard(
                    "Revenue",
                    "₹${revenue.toStringAsFixed(0)}",
                    Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [

                  dashboardCard(
                    title: "Manage Menu",
                    icon: Icons.restaurant_menu,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AdminManageMenuScreen(),
                          ));
                    },
                  ),

                  dashboardCard(
                    title: "Add Item",
                    icon: Icons.add_circle,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AdminAddItemScreen(),
                          ));
                    },
                  ),

                  dashboardCard(
                    title: "View Orders",
                    icon: Icons.list_alt,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AdminOrdersScreen(),
                          ));
                    },
                  ),

                  dashboardCard(
                    title: "Sales Report",
                    icon: Icons.bar_chart,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const SalesDashboard(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
