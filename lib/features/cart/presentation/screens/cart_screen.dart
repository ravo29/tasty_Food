import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/cart/providers/cart_provider.dart';
import 'package:tasty_food/features/cart/presentation/widgets/cart_item_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color bgGrey = Color(0xFFF7F7F7);

    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final double subTotal = cartNotifier.subTotal;
    const double deliveryFees = 1.00;
    final double total = cartItems.isEmpty ? 0.00 : subTotal + deliveryFees;

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                children: [
                  if (Navigator.of(context).canPop())
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  else
                    const SizedBox(width: 48),
                  const Expanded(
                    child: Text(
                      'Shopping Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 16),

              // --- Content ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Liste des éléments du panier
                      if (cartItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              'Votre panier est vide',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        )
                      else
                       ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemTile(
                            item: item,
                            onDelete: () {
                              // Supprime l'élément sélectionné
                              cartNotifier.removeItem(item.id);
                            },
                            onQuantityChanged: (newQuantity) {
                              // Si la quantité descend à 0, l'élément est automatiquement retiré
                              cartNotifier.updateQuantity(item.id, newQuantity);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),

                      // Bouton Add More Items
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: BorderSide(color: primaryGreen.withValues(alpha: 0.5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Add More Items',
                          style: TextStyle(
                            color: primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Coupon de réduction
                      const Text(
                        'Discount Coupon',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Promo Code',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(80, 46), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: const Text('Apply'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Totaux
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sub total', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          Text('\$${subTotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Delivery fees', style: TextStyle(color: Colors.grey, fontSize: 14)),
                          Text('\$${deliveryFees.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text('\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // --- Bouton Checkout ---
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}