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
    FoodItem(
      id: '1',
      name: 'Beef Burger',
      category: 'Burger',
      price: '7.99',
      image: 'assets/images/RoastChicken.png',
      description: 'Delicious beef burger with cheese and lettuce.',
      calories: '450 kcal',
    ),
    FoodItem(
      id: '2',
      name: 'Chicken Pasta',
      category: 'Pasta',
      price: '9.50',
      image: 'assets/images/RoastChicken.png',
      description: 'Creamy chicken pasta with herbs.',
      calories: '520 kcal',
    ),
    FoodItem(
      id: '3',
      name: 'Fried Chicken',
      category: 'Chicken',
      price: '8.20',
      image: 'assets/images/RoastChicken.png',
      description: 'Crispy fried chicken pieces.',
      calories: '600 kcal',
    ),
    FoodItem(
      id: '4',
      name: 'Chocolate Cake',
      category: 'Dessert',
      price: '4.99',
      image: 'assets/images/RoastChicken.png',
      description: 'Rich chocolate layer cake.',
      calories: '350 kcal',
    ),
  ];
});