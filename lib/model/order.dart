import 'food_item.dart';

class Order {
  List<FoodItem> items;
  String status;
  String block;
  String room;
  String name;
  DateTime dateTime;

  Order({
    required this.items,
    required this.block,
    required this.room,
    required this.name,
    required this.dateTime,
    this.status = "Pending",
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.price);
}
