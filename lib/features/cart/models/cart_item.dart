/// CartItem représente un produit dans le panier d'achat.
/// 
/// Note architecturale : CartItem contient imageUrl qui est une préoccupation UI.
/// Une refactorisation future pourrait faire référence à FoodItem directement,
/// mais l'approche actuelle est pragmatique pour éviter les dépendances cycliques
/// entre features (cart et menu) et simplifier l'affichage UI du panier.
class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl; // URL de l'image pour l'affichage UI
  final int quantity;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}