class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final int xp;
  final int rewardPoints;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.xp,
    required this.rewardPoints,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? 'user',
      xp: json['xp'] ?? 0,
      rewardPoints: json['reward_points'] ?? 0,
    );
  }
}