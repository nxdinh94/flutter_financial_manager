import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:fe_financial_manager/view/common_widget/svg_container.dart';
import 'package:fe_financial_manager/view/common_widget/switch_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ExpandedArea extends StatefulWidget {
  const ExpandedArea({super.key});
  @override
  State<ExpandedArea> createState() => _ExpandedAreaState();
}

class _ExpandedAreaState extends State<ExpandedArea> {

  bool isExpanded = false;
  bool isIncludeInReport = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (isExpanded) Container(
          child: Column(
            children: [
              MyDivider(),
              MyListTitle(
                title: 'With',
                callback: (){},
                leading: SvgContainer(
                  iconWidth: 30,
                  iconPath: 'assets/svg/person.svg'
                ),
              ),
              MyDivider(),
              const SizedBox(height: 20,),
              MyDivider(),
              MyListTitle(
                title: 'Select event',
                callback: (){},
                leading: SvgContainer(
                  iconWidth: 28,
                  iconPath: 'assets/svg/calendar.svg'
                ),
              ),
              MyDivider(),
              MyListTitle(
                title: 'No remind',
                callback: (){},
                leading: const Icon(Icons.watch_later_outlined, size: 33,)
              ),
              MyDivider(),
              const SizedBox(height: 40,),
              SwitchRow(
                flag: isIncludeInReport,
                callback: (value) {
                  setState(() {
                    isIncludeInReport = value;
                  });
                },
                text: 'Include from report',
              ),
              const SizedBox(height: 5),
              Text(
                "Include this transaction in reports such as Overview",
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),

        const SizedBox(height: 20,),
        Container(
          height: 40,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            onPressed: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_drop_down_sharp, size: 22),
                const SizedBox(width: 6),
                Text('Add more details', style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
