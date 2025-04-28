import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/common_widget/custom_stack_three_images.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


class BudgetItems extends StatefulWidget {
  const BudgetItems({super.key, required this.data, this.callback, this.paddingBottom = 0});
  final Map<String, dynamic> data;
  final double paddingBottom;
  final VoidCallback ? callback;
  @override
  State<BudgetItems> createState() => _BudgetItemsState();
}

class _BudgetItemsState extends State<BudgetItems> {
  bool isSpendingLimitOutOfDate = false;
  String startTime = '';
  String endTime = '';
  int remainDay = 0;
  double remainMoney = 0;
  String name = '';
  String id = '';
  double initialMoney = 0;
  double totalSpendingMoney = 0;
  double spendingPercentage = 0;

  int onRemainingDay(DateTime endDate) {
    DateTime startDate = DateTime.now();
    Duration difference = endDate.difference(startDate);
    int daysLeft = difference.inDays;
    return daysLeft;
  }


  void updateBudgetsState() {
    DateTime startDate = DateTime.parse(widget.data['budget']['start_date']);
    DateTime endDate = DateTime.parse(widget.data['budget']['end_date']);

    startTime = DateFormat('dd/MM').format(startDate);
    endTime = DateFormat('dd/MM').format(endDate);
    initialMoney = double.parse(widget.data['budget']['amount_of_money']);
    name = widget.data['budget']['name'];
    id = widget.data['budget']['id'];
    totalSpendingMoney =  (widget.data['total_expenses']as int).toDouble();
    remainMoney = (widget.data['remaining_budget_amount'] as int).toDouble();

    if (remainMoney < 0) {
      remainMoney = - remainMoney;
      spendingPercentage = 1;
    } else {
      spendingPercentage = (totalSpendingMoney / initialMoney);
    }

    remainDay = onRemainingDay(endDate);

    if (remainDay <= 0) {
      isSpendingLimitOutOfDate = true;
    } else {
      isSpendingLimitOutOfDate = false;
    }
  }

  @override
  void initState() {
    super.initState();
    updateBudgetsState();
  }

  @override
  void didUpdateWidget(covariant BudgetItems oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(oldWidget.data, widget.data)) {
      setState(() {
        updateBudgetsState();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var currentRoute = GoRouterState.of(context).uri.toString();
    print(currentRoute);
    bool isDetailSpendingLimitItemPage = currentRoute == '/budgets/budgetDetail';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.callback,
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.paddingBottom),
        child: Container(
          color: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            children: [
              Row(
                  children: [
                    Visibility(
                      visible: !isDetailSpendingLimitItemPage,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: StackThreeCircleImages(
                            imageOne: 'assets/icon_category/spending_money_icon/anUong/dinner.png',
                            imageTwo: 'assets/icon_category/spending_money_icon/anUong/cutlery.png',
                            imageThree: 'assets/icon_category/spending_money_icon/anUong/burger_parent.png'
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: isDetailSpendingLimitItemPage ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: !isDetailSpendingLimitItemPage,
                                child: Flexible(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              ),
                              Visibility(
                                visible: isSpendingLimitOutOfDate,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: emergencyColor, width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('Hết hạn', style: TextStyle(
                                      color: emergencyColor, fontSize: small
                                  )),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$startTime - $endTime', style: Theme.of(context).textTheme.labelSmall),
                              MoneyVnd(fontSize: normal, amount: initialMoney),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              const SizedBox(height: 12,),
              MyProgressBar(
                percentage: spendingPercentage,
                color: spendingPercentage >= 0.8 ? Colors.red : secondaryColor,
                lineHeight: 12,
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$remainDay days remain', style: Theme.of(context).textTheme.labelMedium),
                  RichText(
                    text: TextSpan(
                      children: [
                        spendingPercentage == 1 ? TextSpan(
                            text: '( Deficit ) ',
                            style: Theme.of(context).textTheme.labelSmall,
                        ) : const TextSpan(),
                        WidgetSpan(
                          child: MoneyVnd(
                            fontSize: small,
                            amount: remainMoney,
                            textColor:  spendingPercentage == 1 ? emergencyColor : colorTextBlack,
                          ),
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
