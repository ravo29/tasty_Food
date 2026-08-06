import 'package:flutter/material.dart';

// Importation des écrans de chaque onglet
import 'package:tasty_food/features/menu/presentation/screens/home_menu_screen.dart';
import 'package:tasty_food/features/favorites/presentation/screens/favorites_screen.dart';
// Importe tes autres écrans si nécessaire (ex: Cart, Profile)
// import 'package:tasty_food/features/cart/presentation/screens/cart_screen.dart';
// import 'package:tasty_food/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Liste des écrans correspondant aux icônes de la NavBar
  final List<Widget> _screens = const [
    HomeMenuScreen(),     // Index 0 : Accueil
    FavoritesScreen(),    // Index 1 : Favoris
    Center(child: Text('Cart Screen')),    // Index 2 : Panier (à remplacer par ton CartScreen)
    Center(child: Text('Profile Screen')), // Index 3 : Profil (à remplacer par ton ProfileScreen)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack permet de conserver l'état de chaque écran lorsqu'on navigue entre les onglets
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF2E7D32), // Couleur verte principale
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}