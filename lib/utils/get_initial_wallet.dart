import 'package:fe_financial_manager/model/icon_model.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:flutter/material.dart';

// set initial data when create new wallet or existing wallet in transaction
void getInitialData<T extends IconModel>(Function(PickedIconModel) setPickedWalletType, List<dynamic> listData, BuildContext context){
  if (listData.isNotEmpty) {
    T defaultValue = listData[0];
    setPickedWalletType(PickedIconModel(
      icon: defaultValue.icon,
      name: defaultValue.name,
      id: defaultValue.id,
    ));
  }else {
    setPickedWalletType(PickedIconModel(icon: '', name: '', id: ''));
  }
}
