class AccountTypeIconListModel {
  List<AccountTypeIconModel>? accountTypeIconList;

  AccountTypeIconListModel({required this.accountTypeIconList});

  // Constructor fromJson
  AccountTypeIconListModel.fromJson(List<Map<String, dynamic>> json)
      : accountTypeIconList =
  json.map((accountTypeIcon) => AccountTypeIconModel.fromJson(accountTypeIcon)).toList();

  List<Map<String, dynamic>> toJson() {
    return accountTypeIconList?.map((accountTypeIcon) => accountTypeIcon.toJson()).toList() ?? [];
  }
}



class AccountTypeIconModel {
  final String id;
  final String name;
  final String icon;

  AccountTypeIconModel({required this.name, required this.icon, required this.id});

  factory AccountTypeIconModel.fromJson(Map<String, dynamic> json) {
    return AccountTypeIconModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}