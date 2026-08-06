class FoodItem {
  final String id;
  final String name;
  final String category;
  final String price;
  final String image;
  final String description;
  final String calories;
  final bool isFavorite;

  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.calories,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'image': image,
      'description': description,
      'calories': calories,
      'isFavorite': isFavorite,
    };
  }

  FoodItem copyWith({
    String? id,
    String? name,
    String? category,
    String? price,
    String? image,
    String? description,
    String? calories,
    bool? isFavorite,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}