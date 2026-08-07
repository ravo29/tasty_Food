import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
import 'package:tasty_food/features/menu/providers/filter_provider.dart';
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';
import 'package:tasty_food/features/profile/providers/profile_provider.dart';

// Détail
import 'package:tasty_food/features/menu/presentation/screens/food_detail_screen.dart';

class _AppAssets {
  static const String burgerCategory = 'assets/images/burger.png';
  static const String pizzaCategory = 'assets/images/MargheritaPizza.png';
  static const String chickenCategory = 'assets/images/RoastChicken.png';
  static const String pastaCategory = 'assets/images/SpaghettiCarbonara.png';
  static const String drinksCategory = 'assets/images/Cappuccino.png';
  static const String dessertCategory = 'assets/images/ChocolateCake.png';
}

class HomeMenuScreen extends ConsumerWidget {
  const HomeMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color bgGrey = Color(0xFFF7F7F7);

    final user = ref.watch(profileProvider);
    final asyncFilteredMenu = ref.watch(filteredMenuProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final favoriteIds = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(user.avatarUrl),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.check_circle, color: Colors.black, size: 16),
                            ],
                          ),
                          const Text(
                            '123 Main Street, New York',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3E8E1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Recherche et Tri
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            ref.read(searchQueryProvider.notifier).state = value;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 22),
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        final currentSort = ref.read(sortByPriceProvider);
                        ref.read(sortByPriceProvider.notifier).state =
                            currentSort == 'price_asc' ? 'price_desc' : 'price_asc';

                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              currentSort == 'price_asc'
                                  ? 'Tri par prix décroissant'
                                  : 'Tri par prix croissant',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3E8E1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.tune, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Bannière Promo
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Get 50% off Today!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Hot Deal of the\nBurgar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -10,
                        bottom: -10,
                        top: -10,
                        child: Image.asset(
                          _AppAssets.burgerCategory,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, size: 80, color: Colors.white24),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Catégories
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildCategoryChip(context, ref, 'All', null, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Burger', _AppAssets.burgerCategory, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Pizza', _AppAssets.pizzaCategory, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Chicken', _AppAssets.chickenCategory, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Pasta', _AppAssets.pastaCategory, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Drinks', _AppAssets.drinksCategory, selectedCategory, primaryGreen),
                      _buildCategoryChip(context, ref, 'Dessert', _AppAssets.dessertCategory, selectedCategory, primaryGreen),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Liste de plats avec AsyncValue
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Dishes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                asyncFilteredMenu.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: CircularProgressIndicator(color: primaryGreen),
                    ),
                  ),
                  error: (err, stack) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text('Erreur : $err'),
                    ),
                  ),
                  data: (products) {
                    if (products.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text('Aucun plat disponible.'),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final dish = products[index];
                        final String id = dish.id;
                        final String name = dish.name;
                        final String imageUrl = dish.image;
                        final double price = dish.price;
                        final String calories = dish.calories;

                        final bool isFav = favoriteIds.contains(id);

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FoodDetailScreen(dish: dish.toMap()),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03), // Fix deprecated withOpacity
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(18),
                                          bottom: Radius.circular(18),
                                        ),
                                        child: Image.asset(
                                          imageUrl,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => const Icon(
                                            Icons.fastfood,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            ref.read(favoritesProvider.notifier).toggleFavorite(id);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isFav ? Icons.favorite : Icons.favorite_border,
                                              color: isFav ? Colors.red : Colors.grey,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                const Text('🔥', style: TextStyle(fontSize: 10)),
                                                const SizedBox(width: 2),
                                                Text(
                                                  calories,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: primaryGreen,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              '\$${price.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    WidgetRef ref,
    String category,
    String? imagePath,
    String selectedCategory,
    Color primaryGreen,
  ) {
    final isSelected = selectedCategory == category;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          ref.read(selectedCategoryProvider.notifier).state = category;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryGreen : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? primaryGreen : Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              if (imagePath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.restaurant,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}