import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/model/user_model.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  UserModel user = AuthManager.getUser();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('dfafd'),
    );
  }
}
