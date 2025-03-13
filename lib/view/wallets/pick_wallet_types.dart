import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/check_picked_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickWalletTypes extends StatefulWidget {
  PickWalletTypes({super.key, this.pickedWalletTypeId = ''});
  String pickedWalletTypeId;
  @override
  State<PickWalletTypes> createState() => _PickWalletTypesState();
}

class _PickWalletTypesState extends State<PickWalletTypes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose wallet type'),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Consumer<WalletViewModel>(
          builder: (context, value, child) {
            switch(value.iconWalletTypeData.status){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                List<WalletTypeIconModel> listData = value.iconWalletTypeData.data;
                return Column(
                  children: listData.map((e){
                    final PickedIconModel pickedIconModel = PickedIconModel(
                      id: e.id,icon: e.icon, name: e.name
                    );
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                        border: const Border(bottom: BorderSide(color: dividerColor, width: 0.5)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: CheckPickedListTile<PickedIconModel>(
                        iconData: pickedIconModel,
                        pickedIconId: widget.pickedWalletTypeId,
                      ),
                    );
                  }).toList()
                );
              case Status.ERROR:
                return const Center(child: Text('Error'));
              default :
                return const SizedBox.shrink();
            }
          },
        ),
      )
    );
  }
}
