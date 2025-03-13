import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/wallets/widgets/all_wallet_consumer.dart';
import 'package:flutter/material.dart';
class SelectWallets extends StatefulWidget {
  const SelectWallets({super.key}) ;

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
            AllWalletConsumer(),
          ],
        ),
      ),
    );
  }
}
