class Achievement {
  final int id;
  final String title;
  final String description;
  final String icon;
  final int xpReward;
  final bool unlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.xpReward,
    this.unlocked = false,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '⭐',
      xpReward: int.tryParse(json['xp_reward'].toString()) ?? 0,
      unlocked: json['unlocked'] ?? false,
    );
  }
}