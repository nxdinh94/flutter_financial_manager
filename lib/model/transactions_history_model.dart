import 'package:fe_financial_manager/model/wallet_model.dart';

class TransactionHistoryModel {
  final String id;
  final String amountOfMoney;
  final TransactionTypeCategory transactionTypeCategory;
  final SingleWalletModel moneyAccount;
  final String description;
  final DateTime occurDate;
  final bool saveToReport;

  TransactionHistoryModel({
    required this.id,
    required this.amountOfMoney,
    required this.transactionTypeCategory,
    required this.moneyAccount,
    required this.description,
    required this.occurDate,
    required this.saveToReport,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      id: json['id'],
      amountOfMoney: json['amount_of_money'],
      transactionTypeCategory: TransactionTypeCategory.fromJson(json['transaction_type_category']),
      moneyAccount: SingleWalletModel.fromJson(json['money_account']),
      description: json['description'],
      occurDate: DateTime.parse(json['occur_date']),
      saveToReport: json['save_to_report'],
    );
  }
}
class TransactionTypeCategory {
  final String id;
  final String parentId;
  final String icon;
  final String name;
  final String transactionType;

  TransactionTypeCategory({
    required this.id,
    required this.parentId,
    required this.icon,
    required this.name,
    required this.transactionType,
  });

  factory TransactionTypeCategory.fromJson(Map<String, dynamic> json) {
    return TransactionTypeCategory(
      id: json['id'] ?? '',
      parentId: json['parent_id'] ?? '',
      icon: json['icon'] ?? 'assets/another_icon/empty_box.png',
      name: json['name'],
      transactionType: json['transaction_type']['type'],
    );
  }
}

