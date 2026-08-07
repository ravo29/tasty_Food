import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';

// FutureProvider simule un appel API ou un chargement JSON asynchrone
// et retourne un AsyncValue<List<FoodItem>> dans l'UI
final foodListProvider = FutureProvider<List<FoodItem>>((ref) async {
  // Simulation d'un temps de chargement réseau/base de données (1 seconde)
  await Future.delayed(const Duration(seconds: 1));

  // Liste mockée des plats typés avec FoodItem
  return const [
    // Burgers
    FoodItem(
      id: '1',
      name: 'Beef Burger',
      category: 'Burger',
      price: 7.99,
      image: 'assets/images/burger.png',
      description: 'Delicious beef burger with cheese and lettuce.',
      calories: '450 kcal',
    ),
    FoodItem(
      id: '2',
      name: 'Chicken Burger',
      category: 'Burger',
      price: 6.99,
      image: 'assets/images/ChickenChargha.png',
      description: 'Crispy chicken burger with special sauce.',
      calories: '380 kcal',
    ),
    // Pizza
    FoodItem(
      id: '3',
      name: 'Margherita Pizza',
      category: 'Pizza',
      price: 12.99,
      image: 'assets/images/MargheritaPizza.png',
      description: 'Classic Italian pizza with fresh tomatoes and mozzarella.',
      calories: '650 kcal',
    ),
    FoodItem(
      id: '4',
      name: 'Pepperoni Pizza',
      category: 'Pizza',
      price: 14.50,
      image: 'assets/images/MargheritaPizza.png',
      description: 'Pizza topped with spicy pepperoni and cheese.',
      calories: '720 kcal',
    ),
    // Chicken
    FoodItem(
      id: '5',
      name: 'Roast Chicken',
      category: 'Chicken',
      price: 8.20,
      image: 'assets/images/RoastChicken.png',
      description: 'Tender roast chicken with herbs.',
      calories: '600 kcal',
    ),
    FoodItem(
      id: '6',
      name: 'Chicken Parmesan',
      category: 'Chicken',
      price: 9.99,
      image: 'assets/images/ChickenParmesan.png',
      description: 'Breaded chicken with tomato sauce and melted cheese.',
      calories: '550 kcal',
    ),
    FoodItem(
      id: '7',
      name: 'Chicken Tikka',
      category: 'Chicken',
      price: 10.50,
      image: 'assets/images/ChickenTikka.png',
      description: 'Spicy grilled chicken with traditional Indian spices.',
      calories: '480 kcal',
    ),
    // Pasta
    FoodItem(
      id: '8',
      name: 'Spaghetti Carbonara',
      category: 'Pasta',
      price: 11.99,
      image: 'assets/images/SpaghettiCarbonara.png',
      description: 'Classic Roman pasta with eggs, cheese, and pancetta.',
      calories: '520 kcal',
    ),
    FoodItem(
      id: '9',
      name: 'Fettuccine Alfredo',
      category: 'Pasta',
      price: 10.50,
      image: 'assets/images/FettuccineAlferdo.png',
      description: 'Creamy pasta with parmesan sauce.',
      calories: '580 kcal',
    ),
    FoodItem(
      id: '10',
      name: 'Pesto Pasta',
      category: 'Pasta',
      price: 9.99,
      image: 'assets/images/PestoPasta.png',
      description: 'Pasta with fresh basil pesto sauce.',
      calories: '450 kcal',
    ),
    // Drinks
    FoodItem(
      id: '11',
      name: 'Cappuccino',
      category: 'Drinks',
      price: 3.99,
      image: 'assets/images/Cappuccino.png',
      description: 'Rich Italian coffee with steamed milk foam.',
      calories: '120 kcal',
    ),
    FoodItem(
      id: '12',
      name: 'Iced Latte',
      category: 'Drinks',
      price: 4.50,
      image: 'assets/images/IcedLatte.png',
      description: 'Refreshing cold coffee with milk.',
      calories: '150 kcal',
    ),
    FoodItem(
      id: '13',
      name: 'Lemonade',
      category: 'Drinks',
      price: 2.99,
      image: 'assets/images/Lemonade.png',
      description: 'Fresh squeezed lemonade with mint.',
      calories: '80 kcal',
    ),
    FoodItem(
      id: '14',
      name: 'Smoothie',
      category: 'Drinks',
      price: 5.99,
      image: 'assets/images/Smoothie.png',
      description: 'Fresh fruit smoothie blend.',
      calories: '200 kcal',
    ),
    FoodItem(
      id: '15',
      name: 'Mojito',
      category: 'Drinks',
      price: 6.50,
      image: 'assets/images/Mojito.png',
      description: 'Refreshing mint and lime cocktail.',
      calories: '180 kcal',
    ),
    FoodItem(
      id: '16',
      name: 'Espresso',
      category: 'Drinks',
      price: 2.50,
      image: 'assets/images/Espresso.png',
      description: 'Strong Italian coffee shot.',
      calories: '5 kcal',
    ),
    // Desserts
    FoodItem(
      id: '17',
      name: 'Chocolate Cake',
      category: 'Dessert',
      price: 4.99,
      image: 'assets/images/ChocolateCake.png',
      description: 'Rich chocolate layer cake.',
      calories: '350 kcal',
    ),
    FoodItem(
      id: '18',
      name: 'Cheesecake',
      category: 'Dessert',
      price: 5.50,
      image: 'assets/images/Cheesecake.png',
      description: 'Creamy New York style cheesecake.',
      calories: '420 kcal',
    ),
    FoodItem(
      id: '19',
      name: 'Tiramisu',
      category: 'Dessert',
      price: 6.99,
      image: 'assets/images/TiramisuCake.png',
      description: 'Classic Italian coffee-flavored dessert.',
      calories: '380 kcal',
    ),
  ];
});