import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/model/ParamsGetTransactionInRangeTime.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/utils/range_time_chart_home_page.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/tab_bar_elements.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class ChooseRangeTime extends StatefulWidget {
  const ChooseRangeTime({super.key, required this.nameOfSelectedRangeTime});
  final String nameOfSelectedRangeTime;

  @override
  State<ChooseRangeTime> createState() => _ChooseRangeTimeState();
}

class _ChooseRangeTimeState extends State<ChooseRangeTime> with TickerProviderStateMixin {
  late final TabController _tabController;
  late int _selectedTab;
  List<String> tabTitles = ['Day', 'Week', 'Month', 'Quarter', 'Custom'];
  late ParamsGetTransactionInRangeTime currentChosenRangeTime;
  @override
  void initState() {
    _selectedTab = 0;
    _tabController = TabController(
      length: tabTitles.length,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });

    currentChosenRangeTime = context.read<TransactionViewModel>().paramsGetTransactionChartInRangeTime;
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Range Time'),
        leading: CustomBackNavbar(
          value: {
            'name' : widget.nameOfSelectedRangeTime,
            'value' : currentChosenRangeTime
          },
        )
      ),
      body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab bar
        Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              children: tabTitles.asMap().entries.map((entry) {
                int index = entry.key;
                String title = entry.value;
                return TabBarElements(
                  tabController: _tabController,
                  selectedTab: _selectedTab,
                  index: index,
                  title: title,
                );
              }).toList()
            ),
          ),
        ),
        // Tab bar view
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Day
              Column(
                children: [
                  MyListTitle(
                    callback: (){
                      String result = getYesterday();
                      context.pop({
                        'name': 'Yesterday',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Yesterday',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,
                  ),
                  MyListTitle(
                    callback: (){
                      String result = getCurrentDay();
                      context.pop({
                        'name': 'Today',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Today',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: ()async{
                      String result = await DateTimeHelper.showDatePicker(context);
                      if(result.isNotEmpty){
                        String formated = DateTimeHelper.convertDateTimeToString(DateTime.parse(result));
                        context.pop({
                          'name': formated,
                          'value': ParamsGetTransactionInRangeTime(
                              from: formated,
                              to: formated,
                              moneyAccountId: ''
                          ),
                        });
                      }
                    },
                    title: 'Others',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,
                  ),

                ],
              ),
              // Week
              Column(
                children: [
                  MyListTitle(
                    callback: (){
                      String result = getThisWeek();
                      context.pop({
                        'name': 'This Week',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'This Week',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: (){
                      String result = getLastWeek();
                      context.pop({
                        'name': 'Last Week',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Last Week',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,
                  ),

                ],
              ),
              // Month
              Column(
                children: [
                  MyListTitle(
                    callback: (){
                      String result = getThisMonth();
                      context.pop({
                        'name': 'This Month',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'This Month',
                    hideTrailing: false,
                    isShowAnimate: false,
                    hideBottomBorder: false,
                  ),
                  MyListTitle(
                    callback: (){
                      String result = getLastMonth();
                      context.pop({
                        'name': 'Last Month',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Last Month',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: ()async{
                      showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        monthPickerDialogSettings: MonthPickerDialogSettings(
                          headerSettings: PickerHeaderSettings(
                            headerBackgroundColor: secondaryColor,
                            hideHeaderRow: true,
                            headerCurrentPageTextStyle:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(color: colorTextWhite),
                            headerSelectedIntervalTextStyle:
                              Theme.of(context).textTheme.headlineLarge!.copyWith(color: colorTextWhite),
                          ),
                          dialogSettings: PickerDialogSettings(
                            locale: const Locale('en'),
                            dialogRoundedCornersRadius: 20,
                            dialogBackgroundColor: primaryColor,
                          ),
                          dateButtonsSettings: PickerDateButtonsSettings(
                            selectedDateRadius: 12,
                            monthTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: colorTextWhite),
                            unselectedMonthsTextColor: colorTextBlack,
                          )


                        )
                      ).then((date) {
                        if (date != null) {
                          int month = date.month;
                          int year = date.year;
                          int numberDayOfMonth = DateTime(year, month + 1, 0).day;

                          String beginMonth = DateTimeHelper.convertDateTimeToString(date);
                          String endMonth = DateTimeHelper.formatToDoubleDigitDate('$year-$month-$numberDayOfMonth');
                          context.pop({
                            'name': '$beginMonth/$endMonth',
                            'value': ParamsGetTransactionInRangeTime(
                              from: beginMonth,
                              to: endMonth,
                              moneyAccountId: ''
                            ),
                          });
                        }
                      });
                    },
                    title: 'Others',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                ],
              ),
              // Quarter
              Column(
                children: [
                  MyListTitle(
                    callback: (){
                      String result = getAllQuartersOfYear()[0];
                      context.pop({
                        'name': 'First Quarter',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'First Quarter',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: (){
                      String result = getAllQuartersOfYear()[1];
                      context.pop({
                        'name': 'Second Quarter',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Second Quarter',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: (){
                      String result = getAllQuartersOfYear()[2];
                      context.pop({
                        'name': 'Third Quarter',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Third Quarter',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,

                  ),
                  MyListTitle(
                    callback: (){
                      String result = getAllQuartersOfYear()[3];
                      context.pop({
                        'name': 'Fourth Quarter',
                        'value': ParamsGetTransactionInRangeTime(
                          from: result.split('/')[0],
                          to: result.split('/')[1],
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'Fourth Quarter',
                    hideTrailing: false,
                    hideBottomBorder: false,
                    isShowAnimate: false,
                  ),
                ],
              ),
              // Custom
              Column(
                children: [
                  MyListTitle(
                    callback: (){
                      context.pop({
                        'name': 'All Time',
                        'value': ParamsGetTransactionInRangeTime(
                          from: '',
                          to: '',
                          moneyAccountId: ''
                        ),
                      });
                    },
                    title: 'All Time',
                    hideTrailing: false,
                    hideBottomBorder: false,
                  ),
                  MyListTitle(
                    callback: (){},
                    title: 'Custom',
                    hideTrailing: false,
                  ),
                  ListTile(
                    onTap: (){},
                    leading: Text('Start'),
                    title: const Text('yyyy-mm-dd'),
                  ),
                  ListTile(
                    onTap: (){},
                    leading: Text('End'),
                    title: const Text('yyyy-mm-dd'),
                    contentPadding: nonePadding,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    dense: true,


                  ),
                ],
              )

            ],
          )
        )
      ],
    )
    );
  }
}
