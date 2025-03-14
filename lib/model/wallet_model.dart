import 'package:fe_financial_manager/model/icon_model.dart';

class WalletModel extends IconModel {
  final String accountBalance;

  WalletModel({required super.id, required  super.name, required super.icon, required this.accountBalance});

  factory WalletModel.fromJson(Map<String, dynamic> json){
    return WalletModel(
      id : json['id'] ?? '',
      name : json['name'] ?? '',
      icon : json['money_account_type']['icon']  ?? '',
      accountBalance : json['account_balance'] ?? ''
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'money_account_type': {
        'icon': icon,
      },
      'account_balance': accountBalance,
    };
  }

}