
class CategoriesIconListModel {
  List<CategoriesIconModel>? categoriesIconExpenseList;
  List<CategoriesIconModel>? categoriesIconIncomeList;
  Map<String, dynamic>? categoriesIconListMap;

  CategoriesIconListModel({
    this.categoriesIconExpenseList,
    this.categoriesIconIncomeList,
  }) {
    categoriesIconListMap = {};
  }

  CategoriesIconListModel.fromJson(Map<String, dynamic> json) {
    categoriesIconListMap = {}; // Khởi tạo map

    if (json['expense'] != null) {
      categoriesIconExpenseList = <CategoriesIconModel>[];
      json['expense'].forEach((v) {
        categoriesIconExpenseList!.add(CategoriesIconModel.fromJson(v));
      });
      categoriesIconListMap!['expense'] = categoriesIconExpenseList;
    }

    if (json['income'] != null) {
      categoriesIconIncomeList = <CategoriesIconModel>[];
      json['income'].forEach((v) {
        categoriesIconIncomeList!.add(CategoriesIconModel.fromJson(v));
      });
      categoriesIconListMap!['income'] = categoriesIconIncomeList;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'expense': categoriesIconExpenseList?.map((e) => e.toJson()).toList(),
      'income': categoriesIconIncomeList?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoriesIconModel {
  final String id;
  final String name;
  final String transactionTypeId;
  final String icon;
  final String ? parentId;
  final List<CategoriesIconModel> children;

  CategoriesIconModel({
    required this.id,
    required this.name,
    required this.transactionTypeId,
    required this.icon,
    this.parentId,
    required this.children,
  });

  factory CategoriesIconModel.fromJson(Map<String, dynamic> json) {
    return CategoriesIconModel(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      transactionTypeId: json['transaction_type_id'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      parentId: json['parent_id'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoriesIconModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'transaction_type_id': transactionTypeId,
      'icon': icon,
      'parent_id': parentId,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

}
