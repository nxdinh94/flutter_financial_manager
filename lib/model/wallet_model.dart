class WalletModel {
  final String id;
  final String name;
  final String icon;
  final String accountBalance;
  WalletModel({required this.id, required  this.name, required  this.icon, required  this.accountBalance});

  factory WalletModel.fromJson(Map<String, dynamic> json){
    return WalletModel(
      id : json['id'] ?? '',
      name : json['name'] ?? '',
      icon : json['money_account_type']['icon']  ?? '',
      accountBalance : json['account_balance'] ?? ''
    );
  }

}