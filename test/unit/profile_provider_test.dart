import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/profile/models/user_profile.dart';
import 'package:tasty_food/features/profile/providers/profile_provider.dart';

void main() {
  group('ProfileProvider Tests', () {
    test('profileProvider should return mock UserProfile', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final profile = container.read(profileProvider);

      expect(profile, isA<UserProfile>());
      expect(profile.name, 'Sophia Williams');
      expect(profile.email, 'sophia@gmail.com');
      expect(profile.avatarUrl, 'assets/images/AboutImage.png');
      expect(profile.isVerified, true);
    });

    test('UserProfile should have correct properties', () {
      final profile = UserProfile(
        name: 'Test User',
        email: 'test@example.com',
        avatarUrl: 'assets/images/test.png',
        isVerified: false,
      );

      expect(profile.name, 'Test User');
      expect(profile.email, 'test@example.com');
      expect(profile.avatarUrl, 'assets/images/test.png');
      expect(profile.isVerified, false);
    });

    test('UserProfile should default isVerified to true', () {
      final profile = UserProfile(
        name: 'Test User',
        email: 'test@example.com',
        avatarUrl: 'assets/images/test.png',
      );

      expect(profile.isVerified, true);
    });
  });
}