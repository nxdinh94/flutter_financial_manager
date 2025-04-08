import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/wallets/widgets/all_wallet_consumer.dart';
import 'package:flutter/material.dart';
class SelectWallets extends StatefulWidget {
  const SelectWallets({super.key, required this.pickedWallet, required this.onItemTap}) ;
  final PickedIconModel pickedWallet;
  final Future<void> Function(PickedIconModel) onItemTap;
  @override
  State<SelectWallets> createState() => _SelectWalletsState();
}

class _SelectWalletsState extends State<SelectWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Wallets'),
        leading: CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            AllWalletConsumer(
              pickedWallet: widget.pickedWallet,
              onItemTap: widget.onItemTap,
            ),
          ],
        ),
      ),
    );
  }
}
