import 'package:flutter/material.dart';
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_picked_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:provider/provider.dart';

class AllWalletConsumer extends StatelessWidget {
  const AllWalletConsumer({
    super.key,
    this.pickedWallet,
    required this.onItemTap,
    this.trailingCallbackForCheckPickedListTile,
  });
  final PickedIconModel ? pickedWallet;
  final Future<void> Function(PickedIconModel) onItemTap;
  final void Function(PickedIconModel) ? trailingCallbackForCheckPickedListTile;
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, value, child) {
        switch(value.allWalletData.status){
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.COMPLETED:
            List<WalletModel> listData = value.allWalletData.data;
            return listData.isEmpty ? Text('Empty'): Column(
              children: listData.asMap().entries.map((e){
                WalletModel val = e.value;
                double balance = double.parse(val.accountBalance);
                return CheckPickedListTile(
                  subtitle: MoneyVnd(fontSize: normal, amount: balance, textColor: colorTextLabel,),
                  iconData: e.value,
                  titleTextStyle: Theme.of(context).textTheme.titleLarge,
                  onTap: (PickedIconModel value)async{
                    await onItemTap(value);
                  },
                  pickedIconId: pickedWallet?.id,
                  onTrailingTap: trailingCallbackForCheckPickedListTile,
                );
              }).toList()
            );
          case Status.ERROR:
            return const Center(child: Text('Error'));
          default :
            return const SizedBox.shrink();
        }
      },
    );
  }
}
