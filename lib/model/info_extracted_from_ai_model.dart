import 'package:fe_financial_manager/model/transactions_history_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';

class InfoExtractedFromAiModel extends TransactionHistoryModel{

  InfoExtractedFromAiModel({
    required super.amountOfMoney,
    required super.occurDate,
    required super.description,
    required super.transactionTypeCategory,
    required super.moneyAccount,
    required super.saveToReport,
    required super.id,
  });

  factory InfoExtractedFromAiModel.fromJson(Map<String, dynamic> json) {
    return InfoExtractedFromAiModel(
      amountOfMoney: json['amount_of_money'] ?? '0',
      occurDate: DateTime.parse(json['occur_date'] ?? DateTime.now().toString()),
      description: json['description'] ?? '',
      transactionTypeCategory: TransactionTypeCategory.fromJson(json['category']),
      moneyAccount: SingleWalletModel.fromJson(json['wallet_type']),
      saveToReport: true,
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount_of_money': amountOfMoney,
      'occur_date': occurDate.toIso8601String(),
      'description': description,
    };
  }
}
