import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/profile/models/user_profile.dart';

final profileProvider = Provider<UserProfile>((ref) {
  return UserProfile(
    name: 'Sophia Williams',
    email: 'sophia@gmail.com',
    avatarUrl: 'assets/images/AboutImage.png',
    isVerified: true,
  );
});