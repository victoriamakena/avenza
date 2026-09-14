class AppUser {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final int xp;
  final int rewardPoints;
  final int streak;
  final bool emailVerified;

  AppUser({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.xp = 0,
    this.rewardPoints = 0,
    this.streak = 0,
    this.emailVerified = false,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      xp: int.tryParse(json['xp'].toString()) ?? 0,
      rewardPoints:
          int.tryParse(json['reward_points'].toString()) ?? 0,
      streak: int.tryParse(json['streak'].toString()) ?? 0,
      emailVerified: json['email_verified_at'] != null,
    );
  }
}