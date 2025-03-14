import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';

// set initial data when create new wallet or existing wallet in transaction
void getInitialData(Function(PickedIconModel) setPickedWalletType, List<dynamic> listData, BuildContext context){
  if (listData.isNotEmpty) {
    WalletTypeIconModel defaultWalletType = listData[0];
    setPickedWalletType(PickedIconModel(
      icon: defaultWalletType.icon,
      name: defaultWalletType.name,
      id: defaultWalletType.id,
    ));
  }else {
    setPickedWalletType(PickedIconModel(icon: '', name: '', id: ''));
  }
}
