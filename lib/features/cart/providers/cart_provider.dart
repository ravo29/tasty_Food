import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/cart/models/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier()
      : super(const [
          CartItem(
            id: '1',
            name: 'Cappuccino',
            price: 3.45,
            imageUrl: 'assets/images/Cappuccino.png',
            quantity: 1,
          ),
          CartItem(
            id: '2',
            name: 'Iced Latte Frappe',
            price: 2.50,
            imageUrl: 'assets/images/IcedLatte.png',
            quantity: 1,
          ),
        ]);

  void addItem(CartItem item) {
    final index = state.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity + item.quantity)
          else
            state[i]
      ];
    } else {
      state = [...state, item];
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateQuantity(String id, int quantity) {
    if (quantity <= 0) {
      removeItem(id);
      return;
    }
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(quantity: quantity) else item
    ];
  }
  
  void clearCart() {
    state = [];
  }
  
  // Derived values calculés à partir de l'état
  double get subTotal => state.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Providers séparés pour les valeurs dérivées
final cartSubtotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider.notifier).subTotal;
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider.notifier).itemCount;
});