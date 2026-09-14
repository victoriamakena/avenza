class Reward {
  final int id;
  final String title;
  final String description;
  final int pointsRequired;
  final String category;
  final bool available;

  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsRequired,
    required this.category,
    this.available = true,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      pointsRequired: int.tryParse(json['points_cost'].toString()) ?? 0,
      category: json['type'] ?? 'Voucher',
      available: true,
    );
  }
}