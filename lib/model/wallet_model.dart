import 'package:fe_financial_manager/model/icon_model.dart';

// Model for get all wallets
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
// Model for get single wallets
class SingleWalletModel {
  final String id;
  final String name;
  final String initialBalance;
  final String? accountBalance;
  final String? creditLimit;
  final String? description;
  final String? reminderWhenDue;
  final String? bankType;
  final List<dynamic> creditCardReminders;
  final String walletTypeIconPath;
  final String walletTypeName;
  final String walletTypeId;
  SingleWalletModel({
    required this.id,
    required this.name,
    required this.initialBalance,
    this.accountBalance,
    required this.walletTypeIconPath,
    required this.walletTypeName,
    required this.walletTypeId,
    this.creditLimit,
    this.description,
    this.reminderWhenDue,
    this.bankType,
    required this.creditCardReminders,
  });

  factory SingleWalletModel.fromJson(Map<String, dynamic> json) {
    return SingleWalletModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      initialBalance: json['initial_balance'] ?? '0',
      accountBalance: json['account_balance'] ?? '0',
      walletTypeIconPath: json['money_account_type']['icon'] ?? '',
      walletTypeName: json['money_account_type']['name'] ?? '',
      walletTypeId: json['money_account_type']['id'] ?? '',
      creditLimit: json['credit_limit'] ?? '0',
      description: json['description'] ?? '',
      reminderWhenDue: json['reminder_when_due'] ?? '',
      bankType: (json['bank_type']?? 0).toString(),
      creditCardReminders: json['credit_card_reminders'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'initial_balance': initialBalance,
      'account_balance': accountBalance,
      'money_account_type': {
        'icon': walletTypeIconPath,
        'name': walletTypeName,
        'id': walletTypeId,
      },
      'credit_limit': creditLimit,
      'description': description,
      'reminder_when_due': reminderWhenDue,
      'bank_type': bankType,
      'credit_card_reminders': creditCardReminders,
    };
  }
}


