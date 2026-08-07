import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import du provider profile
import 'package:tasty_food/features/profile/providers/profile_provider.dart';

// Navigation vers la page panier (My Orders)
import 'package:tasty_food/features/cart/presentation/screens/cart_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color bgGrey = Color(0xFFF7F7F7);

    final user = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              // --- En-tête ---
              const Text(
                'Your Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // --- Avatar avec l'image AboutImage.png et le badge vérifié ---
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        image: AssetImage(user.avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (user.isVerified)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF00C853),
                        size: 22,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // --- Nom & Email ---
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 28),

              // --- Options du Profil ---

              // 1. Personal Information
              _buildMenuItem(
                context,
                icon: Icons.person_outline_rounded,
                title: 'Personal Information',
                onTap: () {
                  _showDetailModal(
                    context,
                    'Personal Information',
                    'Nom : ${user.name}\nEmail : ${user.email}\nTéléphone : +261 34 00 000 00',
                  );
                },
              ),

              // 2. My Orders (Navigue vers la page Panier)
              _buildMenuItem(
                context,
                icon: Icons.inventory_2_outlined,
                title: 'My Orders',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),

              // 3. Addresses
              _buildMenuItem(
                context,
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                onTap: () {
                  _showDetailModal(
                    context,
                    'Addresses',
                    'Adresse principale :\n123 Rue de la Gastronomie, Antananarivo',
                  );
                },
              ),

              // 4. Payment Methods
              _buildMenuItem(
                context,
                icon: Icons.credit_card_outlined,
                title: 'Payment Methods',
                onTap: () {
                  _showDetailModal(
                    context,
                    'Payment Methods',
                    '• Mobile Money (MVola, Orange Money)\n• Carte Bancaire (**** 4589)',
                  );
                },
              ),

              // 5. Settings
              _buildMenuItem(
                context,
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  _showDetailModal(
                    context,
                    'Settings',
                    '• Notifications : Activées\n• Langue : Français\n• Mode Sombre : Désactivé',
                  );
                },
              ),

              // 6. Help & Support
              _buildMenuItem(
                context,
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {
                  _showDetailModal(
                    context,
                    'Help & Support',
                    'Besoin d\'aide ?\nContactez notre support : support@tastyfood.com\nTél : +261 32 00 000 00',
                  );
                },
              ),

              // 7. Logout
              _buildMenuItem(
                context,
                icon: Icons.logout_rounded,
                title: 'Logout',
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper pour chaque ligne du menu
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: Colors.black87, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xFF2E7D32),
          size: 16,
        ),
      ),
    );
  }

  // Modal d'affichage des détails
  void _showDetailModal(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        ),
      ),
    );
  }

  // Dialogue de confirmation de déconnexion
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Redirection vers l'écran d'accueil/login en réinitialisant la pile de navigation
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text('Se déconnecter', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}