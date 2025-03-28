import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/data/response/status.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/adding_circle.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/wallets/widgets/all_wallet_consumer.dart';
import 'package:fe_financial_manager/view/wallets/widgets/total_balance_wallets.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/picked_icon_model.dart';
class AllWallets extends StatefulWidget {
  const AllWallets({super.key});

  @override
  State<AllWallets> createState() => _AllWalletsState();
}

class _AllWalletsState extends State<AllWallets> {

  double totalBalanceWallets = 0;
  late List<WalletModel> walletList;
  @override
  void initState() {
    ApiResponse data  = context.read<WalletViewModel>().allWalletData;
    if(data.status == Status.COMPLETED){
      walletList = data.data;
      for (var e in walletList) {
        totalBalanceWallets += double.parse(e.accountBalance);
      }
    }else {
      walletList = [];
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallets'),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            //Total balance wallet widgets
            TotalBalanceWallets(balance: totalBalanceWallets),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text('INCLUDED IN TOTAL', style: Theme.of(context).textTheme.labelSmall,),
            ),
            const SizedBox(height: 6),

            // List all wallet
            AllWalletConsumer(
              onItemTap: (PickedIconModel value ) {},
              onReturnWholeItem: (value) {
                WalletModel dataToUpdate = value as WalletModel;
                context.push(FinalRoutes.addWalletsPath, extra: dataToUpdate);
              },
            ),

            const SizedBox(height: 20),
            MyListTitle(
              callback: (){
                context.push(FinalRoutes.addWalletsPath);
},
              title: 'Add wallet',
              titleTextStyle:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: secondaryColor),
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: AddingCircle(),
              ),
              hideTrailing: false,
              hideTopBorder: false,
              hideBottomBorder: false,
            ),
          ],
        ),
      ),
    );
  }
}

