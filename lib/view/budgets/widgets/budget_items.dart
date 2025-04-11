import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/view/common_widget/custom_stack_three_images.dart';
import 'package:fe_financial_manager/view/common_widget/money_vnd.dart';
import 'package:fe_financial_manager/view/common_widget/progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class BudgetItems extends StatefulWidget {
  BudgetItems({super.key, required this.itemSpendingLimit, this.callback, this.paddingBottom = 0});
  final Map<String, dynamic> itemSpendingLimit;
  double paddingBottom;
  VoidCallback ? callback;
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



  bool onSpendingLimitOutOfDate(DateTime endDate) {
    DateTime now = DateTime.now();
    int endDateToSecond = dateTimeToSecondsSinceEpoch(endDate);
    int nowToSecond = dateTimeToSecondsSinceEpoch(now);
    return nowToSecond > endDateToSecond;
  }

  void updateBudgetsState() {
    DateTime startDate = DateTime.parse(widget.itemSpendingLimit['start_time']);
    DateTime endDate = DateTime.parse(widget.itemSpendingLimit['end_time']);

    startTime = DateFormat('dd/MM').format(startDate);
    endTime = DateFormat('dd/MM').format(endDate);
    isSpendingLimitOutOfDate = onSpendingLimitOutOfDate(endDate);
    initialMoney = double.parse(widget.itemSpendingLimit['amount_of_money'][r'$numberDecimal']);
    name = widget.itemSpendingLimit['name'];
    id = widget.itemSpendingLimit['_id'];
    totalSpendingMoney = double.parse(widget.itemSpendingLimit['total_spending'][r'$numberDecimal']);
    remainMoney = initialMoney - totalSpendingMoney;

    if (remainMoney < 0) {
      remainMoney = - remainMoney;
      spendingPercentage = 1;
    } else {
      spendingPercentage = (totalSpendingMoney / initialMoney);
    }

    // Calculate remain day
    int endDay = endDate.day;
    if (isSpendingLimitOutOfDate) {
      remainDay = 0;
    } else {
      remainDay = endDay - DateTime.now().day;
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
    if (!mapEquals(oldWidget.itemSpendingLimit, widget.itemSpendingLimit)) {
      setState(() {
        updateBudgetsState();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var currentRoute = GoRouterState.of(context).uri.toString();
    bool isDetailSpendingLimitItemPage = currentRoute == '/detailSpendingLimitItem';

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
                      child: const StackThreeCircleImages(
                          imageOne: 'assets/icon_category/spending_money_icon/anUong/dinner.png',
                          imageTwo: 'assets/icon_category/spending_money_icon/anUong/cutlery.png',
                          imageThree: 'assets/icon_category/spending_money_icon/anUong/burger_parent.png'
                      ),
                    ),
                    const SizedBox(width: 12,),
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
                              Text('$startTime - $endTime', style: const TextStyle(color: colorTextLabel, fontSize: tiny)),
                              MoneyVnd(
                                  fontSize: normal, amount: 20000,
                              ),
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
                color: spendingPercentage >= 0.8 ? Colors.red : Colors.orangeAccent,
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
                            amount: 999999999,
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
