// lib/features/auth/presentation/screens/auth_form_screen.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../main_screen.dart';

class AuthFormScreen extends StatefulWidget {
  final bool isSignUp;

  const AuthFormScreen({super.key, this.isSignUp = false});

  @override
  State<AuthFormScreen> createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  late bool isSignUpSelected;
  bool isPasswordObscured = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSignUpSelected = widget.isSignUp;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainGreen = Color(0xFF2E7D32); // Vert sombre de fond
    const Color cardBgColor = Color(0xFFD7EAD7); // Vert très clair du panneau
    const Color tabSelectedGreen = Color(0xFF1B5E20); // Vert du bouton d'onglet sélectionné

    return Scaffold(
      backgroundColor: mainGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 1. Logo Tasty Food en haut
                Image.asset(
                  AppAssets.logoTastyFood,
                  height: 120,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                // 2. Panneau Vert Clair Arrondi
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // --- Switcher Onglets Log In / Sign In ---
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() => isSignUpSelected = false),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: !isSignUpSelected ? Colors.white : Colors.transparent,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(
                                            color: !isSignUpSelected ? mainGreen : Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() => isSignUpSelected = true),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isSignUpSelected ? tabSelectedGreen : Colors.transparent,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                            color: isSignUpSelected ? Colors.white : Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 35),

                            // --- Champ E-mail ---
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // --- Champ Mot de passe ---
                            TextField(
                              controller: _passwordController,
                              obscureText: isPasswordObscured,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordObscured = !isPasswordObscured;
                                    });
                                  },
                                ),
                              ),
                            ),

                            // Option Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: Colors.green[900],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // --- Bouton principal Log In / Sign In ---
                            SizedBox(
                              width: 140,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigation vers le catalogue principal (MainScreen)
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => const MainScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: mainGreen,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  isSignUpSelected ? "Sign In" : "Log In",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // --- Boutons Social Login ---
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Text("G", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18)),
                                    label: const Text("Log in with Google", style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.facebook, color: Colors.blue, size: 20),
                                    label: const Text("Log in with Facebook", style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. Décoration légumes en bas de page
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}