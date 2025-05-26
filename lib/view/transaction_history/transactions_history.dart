import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view/common_widget/empty_value_screen.dart';
import 'package:fe_financial_manager/view/transaction_history/widgets/choose_range_time_section.dart';
import 'package:fe_financial_manager/view/transaction_history/widgets/credit_information.dart';
import 'package:fe_financial_manager/view/transaction_history/widgets/total_expense_and_income_banner.dart';
import 'package:fe_financial_manager/view/transaction_history/widgets/transaction_history_detail.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../common_widget/loading_animation.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({
    super.key, this.nameOfSelectedRangeTime, this.walletId});
  final String ? nameOfSelectedRangeTime;
  final String ? walletId;
  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  String selectedTimeToShow = 'All the time';

  Future<void> _onSelectRangeTime()async{
    dynamic result =
    await context.push(
        FinalRoutes.chooseRangeTimeToShowTransactionPath, extra: widget.nameOfSelectedRangeTime
    );
    if(!context.mounted) return;
    // if user cancel the choose range time
    if(result == false){
      return;
    }
    ParamsGetTransactionInRangeTime rangeTime = result['value']!;
    setState(() {
      selectedTimeToShow = result['name'];
    });
    await Provider.of<TransactionViewModel>(context, listen: false).getTransactionInRangeTime(
      ParamsGetTransactionInRangeTime(
        from : rangeTime.from ,
        to : rangeTime.to,
        moneyAccountId : widget.walletId ??  '')
    );
  }

  @override
  void initState() {
    if(widget.nameOfSelectedRangeTime != null){
      selectedTimeToShow =  widget.nameOfSelectedRangeTime!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const Border dashBorder = DashedBorder(
      dashLength: 5, left: BorderSide(color: dividerColor, width: 1),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions History'),
        leading: const CustomBackNavbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChooseRangeTimeSection(
              selectedTimeToShow: selectedTimeToShow,
              onSelectRangeTime: _onSelectRangeTime,
            ),
            const SizedBox(height: 12),
            Consumer<TransactionViewModel>(
              builder: (context, value, child) {
                Status? status = Status.LOADING;
                Map<String, dynamic> data = {};
                if(widget.nameOfSelectedRangeTime != null){
                  status = value.transactionHistoryData.status;
                  data = value.transactionHistoryData.data as Map<String, dynamic>;
                }else {
                  status = value.transactionByWalletInRangeTime.status;
                  data = value.transactionByWalletInRangeTime.data as Map<String, dynamic>;
                }
                switch(status){
                  case Status.LOADING:
                    return const Center(
                      child: LoadingAnimation(
                        iconSize: 80,
                        containerHeight: 500,
                      ),
                    );
                  case Status.COMPLETED:
                    String totalIncomeMoney = data['total_all_income'];
                    String totalExpenseMoney = data['total_all_expense'];
                    Map<String, dynamic> records = data['transactions_by_date'] ??{};
                    if(records.isEmpty){
                      return const EmptyValueScreen(title: 'You have no transactions yet', isAccountPage: false, iconSize: 60,);
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TotalExpenseAndIncomeBanner(totalIncomeMoney: totalIncomeMoney, totalExpenseMoney: totalExpenseMoney),
                        const SizedBox(height: 12),
                        // credit widget
                        Visibility(
                          visible: data['money_account_credit_limit'] != null,
                          child: CreditInformation(
                            currentAccountBalance: data['current_account_balance'] ?? '0',
                            moneyAccountCreditLimit: data['money_account_credit_limit'] ?? '0',
                            availableAccountBalance:data['available_account_balance'] ?? '0',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TransactionHistoryDetail(records: records, dashBorder: dashBorder)
                      ],
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text(
                        'Error',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  default:
                    throw Exception('Unknown status');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



