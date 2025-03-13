class ExternalBankModel {
  final double id;
  final String name;
  final String code;
  final String bin;
  final String shortName;
  final String logo;
  final double transferSupported;
  final double lookupSupported;
  final double support;
  final double isTransfer;
  final String swiftCode;

  ExternalBankModel({
    required this.id,
    required this.name,
    required this.code,
    required this.bin,
    required this.shortName,
    required this.logo,
    required this.transferSupported,
    required this.lookupSupported,
    required this.support,
    required this.isTransfer,
    required this.swiftCode,
  });

  /// Convert from JSON
  factory ExternalBankModel.fromJson(Map<String, dynamic> json) {
    return ExternalBankModel(
      id: (json['id'] ?? 0).toDouble(),
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      bin: json['bin'] ?? '',
      shortName: json['short_name'] ?? '', // Giữ nguyên tên key từ JSON
      logo: json['logo'] ?? '',
      transferSupported: (json['transferSupported'] ?? 0).toDouble(),
      lookupSupported: (json['lookupSupported'] ?? 0).toDouble(),
      support: (json['support'] ?? 0).toDouble(),
      isTransfer: (json['isTransfer'] ?? 0).toDouble(),
      swiftCode: json['swift_code'] ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'bin': bin,
      'short_name': shortName,
      'logo': logo,
      'transferSupported': transferSupported,
      'lookupSupported': lookupSupported,
      'support': support,
      'isTransfer': isTransfer,
      'swift_code': swiftCode,
    };
  }
}
