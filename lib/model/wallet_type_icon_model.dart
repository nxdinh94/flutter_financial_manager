import 'package:fe_financial_manager/model/icon_model.dart';

class WalletTypeIconModel extends IconModel {

  WalletTypeIconModel({required super.id, required super.icon, required super.name});

  factory WalletTypeIconModel.fromJson(Map<String, dynamic> json) {
    return WalletTypeIconModel(
      id: json['id'] ?? '',
      icon: json['icon'] ?? 'assets/another_icon/loading-arrow.png',
      name: json['name'] ?? 'unknown',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
    };
  }
}
