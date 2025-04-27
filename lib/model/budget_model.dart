import 'package:fe_financial_manager/model/transactions_history_model.dart';

class BudgetModel {
  final String id;
  final String name;
  final String amountOfMoney;
  final DateTime startDate;
  final DateTime endDate;
  final List<MoneyAccount> moneyAccounts;
  final List<TransactionTypeCategory> transactionTypeCategories;
  final List<TransactionHistoryModel> transactions;

  BudgetModel({
    required this.id,
    required this.name,
    required this.amountOfMoney,
    required this.startDate,
    required this.endDate,
    required this.moneyAccounts,
    required this.transactionTypeCategories,
    required this.transactions,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'],
      name: json['name'],
      amountOfMoney: json['amount_of_money'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      moneyAccounts: (json['money_accounts'] as List)
          .map((e) => MoneyAccount.fromJson(e))
          .toList(),
      transactionTypeCategories: (json['transaction_type_categories'] as List)
          .map((e) => TransactionTypeCategory.fromJson(e))
          .toList(),
      transactions: (json['transactions'] as List)
          .map((e) => TransactionHistoryModel.fromJson(e))
          .toList(),
    );
  }
}

class MoneyAccount {
  final String id;
  final String name;

  MoneyAccount({required this.id, required this.name});

  factory MoneyAccount.fromJson(Map<String, dynamic> json) {
    return MoneyAccount(
      id: json['id'],
      name: json['name'],
    );
  }
}

