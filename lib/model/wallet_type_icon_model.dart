class WalletTypeIconModel {
  final String id;
  final String icon;
  final String name;

  WalletTypeIconModel({required this.id, required this.icon, required this.name});

  factory WalletTypeIconModel.fromJson(Map<String, dynamic> json) {
    return WalletTypeIconModel(
      id: json['id'] ?? '',
      icon: json['icon'] ?? 'assets/another_icon/loading-arrow.png',
      name: json['name'] ?? 'unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
    };
  }
}
