class FoodItem {
  String name;
  double price;
  String category;
  String image;
  bool available;

  FoodItem({
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.available = true,
  });
}
