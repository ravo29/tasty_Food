class UserProfile {
  final String name;
  final String email;
  final String avatarUrl;
  final bool isVerified;

  const UserProfile({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.isVerified = true,
  });
}