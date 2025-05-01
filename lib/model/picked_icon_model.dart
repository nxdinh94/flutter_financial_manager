import 'package:fe_financial_manager/model/icon_model.dart';

class PickedIconModel extends IconModel{
  PickedIconModel({
    required super.icon, required super.name, required super.id, this.userId
    , this.transactionTypeId,
  });
  final dynamic userId;
  final dynamic transactionTypeId;

  // from json
  factory PickedIconModel.fromJson(Map<String, dynamic> json) {
    return PickedIconModel(
      icon: json['icon'],
      name: json['name'],
      id: json['id'],
      userId : json['user_id'],
      transactionTypeId: json['transaction_type_id'] ?? '',
    );
  }
  String toString(){
    return 'PickedIconModel{icon: $icon, name: $name, id: $id, userId: $userId, transactionTypeId: $transactionTypeId}';
  }

}