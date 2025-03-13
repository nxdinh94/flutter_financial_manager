import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/model/external_bank_model.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class ExternalBank extends StatelessWidget {
  const ExternalBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackNavbar(),
        title: const Text('Select bank'),
      ),
      body: Consumer<WalletViewModel>(
        builder: (context, value, child) {
          switch(value.externalBankData.status){
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              List<ExternalBankModel> listData = value.externalBankData.data;
              return ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  return MyListTitle(
                    callback: (){
                      context.pop(
                        PickedIconModel(
                          icon: listData[index].logo,
                          name: listData[index].shortName,
                          id: listData[index].id.toString()
                        )
                      );
                    },
                    title: listData[index].shortName,
                    subTitle: Text(listData[index].name),
                    leading: Image.network(listData[index].logo),
                    hideTrailing: false,
                  );
                },
              );
            case Status.ERROR:
              return const Center(child: Text('Error'));
            default :
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
