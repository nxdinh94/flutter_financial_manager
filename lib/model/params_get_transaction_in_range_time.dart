

class ParamsGetTransactionInRangeTime{
  final String from;
  final String to;
  final String moneyAccountId;
  ParamsGetTransactionInRangeTime({
    required this.from,
    required this.to,
    required this.moneyAccountId,
  });
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'moneyAccountId': moneyAccountId,
    };
  }
}