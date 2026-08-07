import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/cart/models/cart_item.dart';
import 'package:tasty_food/features/cart/providers/cart_provider.dart';

void main() {
  group('CartProvider Tests', () {
    test('CartNotifier should initialize with mock items', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cart = container.read(cartProvider);
      
      expect(cart, hasLength(2));
      expect(cart[0].name, 'Cappuccino');
      expect(cart[1].name, 'Iced Latte Frappe');
    });

    test('CartNotifier should add new item', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      final newItem = CartItem(
        id: '3',
        name: 'Test Item',
        price: 5.99,
        imageUrl: 'assets/images/test.png',
        quantity: 1,
      );

      notifier.addItem(newItem);
      final cart = container.read(cartProvider);

      expect(cart, hasLength(3));
      expect(cart.any((item) => item.id == '3'), true);
    });

    test('CartNotifier should update quantity of existing item', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      final existingItem = CartItem(
        id: '1',
        name: 'Cappuccino',
        price: 3.45,
        imageUrl: 'assets/images/Cappuccino.png',
        quantity: 2,
      );

      notifier.addItem(existingItem);
      final cart = container.read(cartProvider);

      final updatedItem = cart.firstWhere((item) => item.id == '1');
      expect(updatedItem.quantity, 3); // 1 (initial) + 2 (added)
    });

    test('CartNotifier should remove item', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      notifier.removeItem('1');
      
      final cart = container.read(cartProvider);
      expect(cart, hasLength(1));
      expect(cart.any((item) => item.id == '1'), false);
    });

    test('CartNotifier should update quantity', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      notifier.updateQuantity('1', 5);
      
      final cart = container.read(cartProvider);
      final updatedItem = cart.firstWhere((item) => item.id == '1');
      expect(updatedItem.quantity, 5);
    });

    test('CartNotifier should remove item when quantity set to 0', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      notifier.updateQuantity('1', 0);
      
      final cart = container.read(cartProvider);
      expect(cart, hasLength(1));
      expect(cart.any((item) => item.id == '1'), false);
    });

    test('CartNotifier should clear cart', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      notifier.clearCart();
      
      final cart = container.read(cartProvider);
      expect(cart, isEmpty);
    });

    test('CartNotifier should calculate subTotal correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartProvider.notifier);
      final subTotal = notifier.subTotal;
      
      // Cappuccino: 3.45 * 1 = 3.45
      // Iced Latte: 2.50 * 1 = 2.50
      // Total: 5.95
      expect(subTotal, closeTo(5.95, 0.01));
    });

    test('cartSubtotalProvider should calculate correct subtotal', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final subTotal = container.read(cartSubtotalProvider);
      
      expect(subTotal, closeTo(5.95, 0.01));
    });

    test('cartItemCountProvider should calculate correct item count', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final itemCount = container.read(cartItemCountProvider);
      
      expect(itemCount, 2); // 1 + 1 = 2 items
    });
  });
}