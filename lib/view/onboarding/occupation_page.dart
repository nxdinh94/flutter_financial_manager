import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view/common_widget/divider.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';

class OccupationPage extends StatefulWidget {
  const OccupationPage({super.key, required this.callback});
  final VoidCallback callback;
  @override
  State<OccupationPage> createState() => _OccupationPageState();
}
enum Occupation { universityStudent, officeStaff, freelancer, bussinessOwner, other }

class _OccupationPageState extends State<OccupationPage> {
  late List<Map<String, dynamic>> _optionWidgetList;
  Occupation ? _occupation;
  @override
  void initState() {
    _optionWidgetList = [
      {
        'title': 'University Student',
        'icon': Assets.pngGraduated,
        'value': Occupation.universityStudent,
      },
      {
        'title': 'Office Staff',
        'icon': Assets.pngOfficer,
        'value': Occupation.officeStaff,
      },
      {
        'title': 'Freelancer',
        'icon': Assets.pngFreelance,
        'value': Occupation.freelancer,
      },
      {
        'title': 'Business Owner',
        'icon': Assets.pngOwnership,
        'value': Occupation.bussinessOwner,
      },
      {
        'title': 'Other',
        'icon': Assets.pngOthers,
        'value': Occupation.other,
      },
    ];


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: Visibility(
        visible: _occupation != null,
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
                'What is your occupation?',
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
