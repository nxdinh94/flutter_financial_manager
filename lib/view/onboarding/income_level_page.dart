import 'package:fe_financial_manager/generated/assets.dart';
import 'package:flutter/material.dart';

import '../../constants/padding.dart';
import '../common_widget/my_list_title.dart';

class IncomeLevelPage extends StatefulWidget {
  const IncomeLevelPage({super.key, required this.callback});
  final VoidCallback callback;

  @override
  State<IncomeLevelPage> createState() => _IncomeLevelPageState();
}

enum IncomeLevelEnum { one, two, three, four, five, six, other }

class _IncomeLevelPageState extends State<IncomeLevelPage> {
  late List<Map<String, dynamic>> _optionWidgetList;
  IncomeLevelEnum ? _incomeLevel;
  @override
  void initState() {

    _optionWidgetList = [
      {
        'title': '< 1 million VND',
        'icon': Assets.pngIncomeLevelOne,
        'value': IncomeLevelEnum.one,
      },
      {
        'title': '5-10 million VND',
        'icon': Assets.pngIncomeLevelTwo,
        'value': IncomeLevelEnum.two,
      },
      {
        'title': '10-20 million VND',
        'icon': Assets.pngIncomeLevelThree,
        'value': IncomeLevelEnum.three,
      },
      {
        'title': '20-40 million VND',
        'icon': Assets.pngIncomeLevelFour,
        'value': IncomeLevelEnum.four,
      },
      {
        'title': '40-50 million VND',
        'icon': Assets.pngIncomeLevelFive,
        'value': IncomeLevelEnum.five,
      },
      {
        'title': '> 50 million VND',
        'icon': Assets.pngIncomeLevelMax,
        'value': IncomeLevelEnum.six,
      },
      {
        'title': 'Other',
        'icon': Assets.pngLoan,
        'value': IncomeLevelEnum.other,
      },
    ];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: Visibility(
          visible: _incomeLevel != null,
          child: ElevatedButton(
              onPressed: widget.callback,
              child: const Text('Next')
          )
      ),
      body: Container(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is your income level?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              ..._optionWidgetList.map((e){
                return MyListTitle(
                  title: e['title'],
                  callback: (){},
                  leftContentPadding: 0,
                  leading: Image.asset(e['icon'], width: 40,),
                  verticalContentPadding: 4,
                  trailing: Radio<IncomeLevelEnum>(
                    value: e['value'],
                    groupValue: _incomeLevel,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (IncomeLevelEnum? value) {
                      setState(() {
                        _incomeLevel = value;
                      });
                    },
                  ),
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}
