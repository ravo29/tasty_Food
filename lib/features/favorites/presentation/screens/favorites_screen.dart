import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import du provider dédié aux favoris
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';
// Import du provider principal pour pouvoir modifier l'état des favoris (toggle)
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

// Import des widgets et écrans
import 'package:tasty_food/features/menu/presentation/widgets/food_card.dart';
import 'package:tasty_food/features/menu/presentation/screens/food_detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color bgGrey = Color(0xFFF7F7F7);

    // Écoute directe du provider filtré des favoris
    final favoriteDishes = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              // --- En-tête (Header avec Titre et Notification) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bouton retour affiché uniquement si la page a été poussée (Navigator.push)
                  if (Navigator.of(context).canPop())
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  else
                    const SizedBox(width: 40),

                  const Text(
                    'Favorit List',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Liste / Grille des plats favoris ---
              Expanded(
                child: favoriteDishes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 70,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Aucun favori pour le moment',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: favoriteDishes.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final dish = favoriteDishes[index];
                          return FoodCard(
                            dish: dish,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailScreen(dish: dish.toMap()),
                                ),
                              );
                            },
                            onFavoriteToggle: () {
                              // Modification de l'état via le foodListProvider
                              ref.read(foodListProvider.notifier).toggleFavorite(dish.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}