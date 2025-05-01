
import 'package:fe_financial_manager/model/icon_model.dart';

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

class CategoriesIconModel extends IconModel {
  final String transactionTypeId;
  final String parentId;
  final List<CategoriesIconModel> children;
  final dynamic userId;
  CategoriesIconModel({
    required super.id,
    required super.name,
    required super.icon,
    required this.transactionTypeId,
    required this.parentId,
    required this.children,
    this.userId,
  });

  factory CategoriesIconModel.fromJson(Map<String, dynamic> json) {
    return CategoriesIconModel(
      id: json['id'] ?? "",
      name: json['name']  ?? "",
      icon: json['icon']  ?? "",
      transactionTypeId: json['transaction_type_id'] ??  "",
      parentId: json['parent_id'] ?? "",
      userId: json['user_id'],
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoriesIconModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'transaction_type_id': transactionTypeId,
      'icon': icon,
      'parent_id': parentId,
      'user_id': userId,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

}
