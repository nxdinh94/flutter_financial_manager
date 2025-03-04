
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/utils/date_time.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/date_option_bottom_sheets.dart';
import 'package:fe_financial_manager/view/adding_workspace/widgets/expanded_area.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_float_action_button.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {
  final TextEditingController _amountController = TextEditingController();

  // Note
  String note = '';
  // Pick category
  Map<String, String> pickedCategory = {
    'iconPath': '',
    'title': ''
  };

  String getCurrentDate(){
    // return 'Monday,2022-02-02';
    return '${getNameOfDay(getCurrentDayMonthYear())}, ${getCurrentDayMonthYear()}';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dividerIndent = screenHeight * 0.094;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      floatingActionButton: MyFloatActionButton(
        callback: () {  },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            //Pick wallets
            MyListTitle(
              title: 'Tiền mặt',
              callback: () {
                context.push('${RoutesName.addingWorkSpacePath}/${RoutesName.selectWalletPath}');
              },
              leading: Image.asset('assets/account_type/bank.png', width:20),
            ),
            MyDivider(indent: dividerIndent),
            //Pick amount
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: TextField(
                controller: _amountController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 40,
                  height: 0.9
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      right: screenHeight * 0.01,
                      left: screenHeight * 0.016,
                    ),
                    child: Container(
                      height: 30, width: 49,
                      decoration: BoxDecoration(
                        border: Border.all(color: iconColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: SvgContainer(
                        iconWidth: 30,
                        iconPath: 'assets/svg/dong-svg-repo.svg',
                        // myIconColor: Colors.red,
                      )
                    ),
                  ),
                  hintText: '0',
                  isDense: true,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0, minHeight: 0
                  ),
                ),
              )
            ),
            MyDivider(indent: dividerIndent),
            //Pick category
            MyListTitle(
              title: 'Select category',
              titleTextStyle: const TextStyle(
                fontSize: extraBigger,
                color: colorTextLabel,
                fontWeight: FontWeight.w500
              ),
              callback: () async {
                dynamic result = await context.push<Map<String, String>>(
                  '${RoutesName.addingWorkSpacePath}/${RoutesName.pickCategoryPath}', extra: pickedCategory);
                if(result != null){
                  setState(() {
                    pickedCategory = result;
                  });
                }
              },
              verticalContentPadding: 4,
              leading: FittedBox(
                child: Image.asset(
                  'assets/another_icon/wallet-2.png', width:20,
                ),
              ),
            ),
            MyDivider(indent: dividerIndent),
            //Pick note
            MyListTitle(
              title: note.isNotEmpty ? note : 'Note',
              callback: () async {
                final dynamic result =
                  await context.push<String>(
                    '${RoutesName.addingWorkSpacePath}/${RoutesName.addNotePath}', extra: note);
                setState(() {
                  note = result;
                });
              },
              leading: SvgContainer(
                iconWidth: 28,
                iconPath: 'assets/svg/notes.svg'
              ),
            ),
            MyDivider(indent: dividerIndent),
            //Pick date
            MyListTitle(
              title: getCurrentDate(),
              callback: () {
                showDateOptionBottomSheet(context);
              },
              leading: SvgContainer(
                iconWidth: 28,
                iconPath: 'assets/svg/calendar.svg'
              )),
            MyDivider(),
            const SizedBox(height: 20,),
            ExpandedArea(),
            SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}
