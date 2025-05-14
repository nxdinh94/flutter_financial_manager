import 'package:fe_financial_manager/constants/enum.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';

class OccupationPage extends StatefulWidget {
  const OccupationPage({
    super.key, required
    this.callback,
    required this.optionWidgetList,
  });
  final void Function(Occupation) callback;
  final List<Map<String, dynamic>> optionWidgetList;
  @override
  State<OccupationPage> createState() => _OccupationPageState();
}

class _OccupationPageState extends State<OccupationPage> {
  Occupation ? _occupation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: Visibility(
        visible: _occupation != null,
        child: ElevatedButton(
          onPressed: (){
            widget.callback(_occupation!);
          },
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
                'What is your occupation?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              ...widget.optionWidgetList.map((e){
                return MyListTitle(
                  title: e['title'],
                  callback: (){},
                  leftContentPadding: 0,
                  leading: Image.asset(e['icon'], width: 40,),
                  verticalContentPadding: 4,
                  trailing: Radio<Occupation>(
                    value: e['value'],
                    groupValue: _occupation,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (Occupation? value) {
                      setState(() {
                        _occupation = value;
                      });
                    },
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
