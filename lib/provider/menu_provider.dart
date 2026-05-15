import 'package:flutter/material.dart';
import 'package:smartcanteen/model/food_item.dart';

class MenuProvider with ChangeNotifier {

List<FoodItem> _menu = [

  FoodItem(
    name: "Burger",
    price: 50,
    category: "Snacks",
    image: "https://cdn.uengage.io/uploads/29124/image-2341-1771061175.jpg",
  ),
  FoodItem(
    name: "Sandwich",
    price: 40,
    category: "Snacks",
image: "https://images.unsplash.com/photo-1553909489-cd47e0907980",  ),
  FoodItem(
    name: "French Fries",
    price: 60,
    category: "Snacks",
image: "https://images.unsplash.com/photo-1576107232684-1279f390859f"  ),
  FoodItem(
    name: "Samosa",
    price: 20,
    category: "Snacks",
image: "https://images.unsplash.com/photo-1601050690597-df0568f70950"  ),

  FoodItem(
    name: "Pizza",
    price: 100,
    category: "Meals",
    image: "https://wp-cdn.typhur.com/wp-content/uploads/2025/01/homemade-pizza-in-air-fryer.jpg",
  ),
  FoodItem(
    name: "Chicken Roll",
    price: 70,
    category: "Meals",
    image: "https://images.unsplash.com/photo-1604908176997-125f25cc6f3d",),
  FoodItem(
    name: "Fried Rice",
    price: 90,
    category: "Meals",
    image: "https://www.sharmispassions.com/wp-content/uploads/2013/04/EggFriedRice4-500x500.jpg",
  ),
  FoodItem(
    name: "Meals Combo",
    price: 120,
    category: "Meals",
image: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",  ),

  FoodItem(
    name: "Juice",
    price: 30,
    category: "Drinks",
    image: "https://www.acouplecooks.com/wp-content/uploads/2021/06/Strawberry-Water-006.jpg",
  ),
  FoodItem(
    name: "Tea",
    price: 15,
    category: "Drinks",
    image: "https://www.munatycooking.com/wp-content/uploads/2024/04/Three-glasses-filled-with-karak-chai.jpg",
  ),
  FoodItem(
    name: "Coffee",
    price: 25,
    category: "Drinks",
    image: "https://corkframes.com/cdn/shop/articles/Corkframes_Coffee_Guide_520x500_422ebe38-4cfa-42b5-a266-b9bfecabaf30.jpg?v=1734598727",
  ),
  FoodItem(
    name: "Milkshake",
    price: 50,
    category: "Drinks",
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Strawberry_milk_shake_%28cropped%29.jpg/250px-Strawberry_milk_shake_%28cropped%29.jpg",
  ),
];


  List<FoodItem> get menu => _menu;

  void addItem(FoodItem item) {
    _menu.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    _menu.removeAt(index);
    notifyListeners();
  }

  void updateItem(int index, FoodItem newItem) {
    _menu[index] = newItem;
    notifyListeners();
  }

  void toggleAvailability(int index, bool value) {
    _menu[index].available = value;
    notifyListeners();
  }
}
