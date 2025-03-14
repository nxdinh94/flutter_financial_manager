import 'package:fe_financial_manager/model/icon_model.dart';

class PickedIconModel extends IconModel{
  PickedIconModel({required super.icon, required super.name, required super.id});

  bool isNull(){
    return icon.isEmpty && name.isEmpty && id.isEmpty;
  }

}