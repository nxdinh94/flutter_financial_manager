import 'package:fe_financial_manager/model/icon_model.dart';

class PickedIconModel extends IconModel{
  PickedIconModel({
    required super.icon, required super.name, required super.id, this.userId
  });
  final dynamic userId;

  // from json
  factory PickedIconModel.fromJson(Map<String, dynamic> json) {
    return PickedIconModel(
      icon: json['icon'],
      name: json['name'],
      id: json['id'],
      userId : json['user_id'],
    );
  }

}