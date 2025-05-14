import 'package:flutter/material.dart';

import '../../constants/padding.dart';
import '../common_widget/my_list_title.dart';
class FinancialAimPage extends StatefulWidget {
  const FinancialAimPage({super.key, required this.callback, required this.optionWidgetList});
  final VoidCallback callback;
  final List<Map<String, dynamic>> optionWidgetList;
  @override
  State<FinancialAimPage> createState() => _FinancialAimPageState();
}

class _FinancialAimPageState extends State<FinancialAimPage> {

  bool isChosen = false;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Theme.of(context).colorScheme.secondary;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: Visibility(
          visible: isChosen,
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
              ...widget.optionWidgetList.asMap().entries.map((e){
                int index = e.key;
                Map<String, dynamic> value = e.value;
                return MyListTitle(
                  title: value['title'],
                  callback: (){},
                  leftContentPadding: 2,
                  verticalContentPadding: 4,
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    activeColor: Colors.grey,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    value: value['value'],
                    onChanged: (bool? v) {
                      setState(() {
                        value['value'] = v!;
                      });
                      // Check if any checkbox is selected
                      for(final i in widget.optionWidgetList){
                        if(i['value']){
                          setState(() {
                            isChosen = true;
                          });
                          break;
                        }
                        setState(() {
                          isChosen = false;
                        });
                      }
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
