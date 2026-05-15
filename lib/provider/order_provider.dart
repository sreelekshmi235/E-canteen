import 'package:flutter/material.dart';
import 'package:smartcanteen/model/food_item.dart';
import 'package:smartcanteen/model/order.dart';


class OrderProvider with ChangeNotifier {
  List<FoodItem> cart = [];
  List<Order> orders = [];

  void addToCart(FoodItem item) {
    cart.add(item);
    notifyListeners();
  }
void placeOrder(String block, String room, String name) {
  orders.add(
    Order(
      items: List.from(cart),
      block: block,
      room: room,
      name: name,
      dateTime: DateTime.now(),
    ),
  );

  cart.clear();
  notifyListeners();
}



  double get totalRevenue =>
      orders.fold(0, (sum, order) => sum + order.total);

      String get mostSoldItem {
  Map<String, int> count = {};

  for (var order in orders) {
    for (var item in order.items) {
      count[item.name] = (count[item.name] ?? 0) + 1;
    }
  }

  if (count.isEmpty) return "No Sales Yet";

  var sorted = count.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sorted.first.key;
}

}
