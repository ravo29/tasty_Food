import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Imports pour la gestion du panier
import 'package:tasty_food/features/cart/models/cart_item.dart';
import 'package:tasty_food/features/cart/providers/cart_provider.dart';

class FoodDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> dish;

  const FoodDetailScreen({super.key, required this.dish});

  @override
  ConsumerState<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends ConsumerState<FoodDetailScreen> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color bgGrey = Color(0xFFF7F7F7);

    // Extraction sécurisée des données du plat passé en argument
    final String id = widget.dish['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
    final String name = widget.dish['name'] ?? widget.dish['title'] ?? 'Plat sans nom';
    final dynamic rawPrice = widget.dish['price'];
    final double price = (rawPrice is num)
        ? rawPrice.toDouble()
        : double.tryParse(rawPrice?.toString().replaceAll('\$', '') ?? '0') ?? 0.0;
    final String imageUrl = widget.dish['imageUrl'] ?? widget.dish['image'] ?? 'assets/images/RoastChicken.png';
    final String description = widget.dish['description'] ?? 'Délicieux plat préparé avec soin.';

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: Column(
          children: [
            // --- Barre supérieure avec bouton Retour ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40), // Espace d'équilibrage
                ],
              ),
            ),

            // --- Contenu principal du détail ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image centrale du plat
                      Center(
                        child: Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.fastfood, size: 80, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Titre du plat & Sélecteur de quantité
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: _decrementQuantity,
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 18, color: primaryGreen),
                                  onPressed: _incrementQuantity,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Prix unitaire
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Bouton "Add to Cart" ---
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // 1. Ajout de l'élément dans le cartProvider
                  ref.read(cartProvider.notifier).addItem(
                        CartItem(
                          id: id,
                          name: name,
                          price: price,
                          imageUrl: imageUrl,
                          quantity: quantity,
                        ),
                      );

                  // 2. Affichage du message de confirmation
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Ce menu est ajouté dans le panier',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      backgroundColor: primaryGreen,
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text(
                  'Add to Cart - \$${(price * quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}