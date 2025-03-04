import 'package:flutter/material.dart';
class SelectWallets extends StatefulWidget {
  const SelectWallets({super.key});

  @override
  State<SelectWallets> createState() => _SelectWalletsState();
}

class _SelectWalletsState extends State<SelectWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Wallets'),
      ),
    );
  }
}
