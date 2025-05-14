import 'package:fe_financial_manager/constants/enum.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/utils/format_number.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view/onboarding/finish_page.dart';
import 'package:fe_financial_manager/view/onboarding/income_level_page.dart';
import 'package:fe_financial_manager/view/onboarding/occupation_page.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'financial_aim_page.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  late List<Map<String, dynamic>> _optionFinancialAimWidgetList;
  late List<Map<String, dynamic>> _optionOccupationWidgetList;

  String ? _occupation;
  double ? _incomeLevel;
  List<String> ? _financialAim;

  void convertDataForOccupation(Occupation value) {
    switch (value){
      case Occupation.universityStudent:
        _occupation = 'University Student';
        break;
      case Occupation.officeStaff:
        _occupation = 'Office Staff';
        break;
      case Occupation.freelancer:
        _occupation = 'Freelancer';
        break;
      case Occupation.bussinessOwner:
        _occupation = 'Business Owner';
        break;
      case Occupation.other:
        _occupation = 'Other';
        break;
    }
  }
  @override
  void initState() {
    _optionFinancialAimWidgetList = [
      {
        'id': 0,
        'title': 'Save money',
        'value': false,
      },
      {
        'id': 1,
        'title': 'Pay off debt',
        'value': false,
      },
      {
        'id': 2,
        'title': 'Big purchase(a car or a house)',
        'value': false,

      },
      {
        'id': 3,
        'title': 'Travel',
        'value': false,
      },
      {
        'id': 4,
        'title': 'Invest',
        'value': false,
      },
      {
        'id': 5,
        'title': 'Other',
        'value': false,
      },
    ];
    _optionOccupationWidgetList = [
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        OccupationPage(
          callback:  (Occupation value) {
            convertDataForOccupation(value);
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          optionWidgetList: _optionOccupationWidgetList,
        ),
        IncomeLevelPage(
          callback: (String value) {
            _incomeLevel = double.parse(FormatNumber.cleanedNumber(value));
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        FinancialAimPage(
          callback: () {
            for(final i in _optionFinancialAimWidgetList){
              if(i['value'] == true){
                _financialAim ??= [];
                _financialAim?.add(i['title']);
              }
            }
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                3,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          optionWidgetList: _optionFinancialAimWidgetList,
        ),
        FinishPage(
          callback: ()async {
            Map<String, dynamic> dataToSubmit = {
              'occupation': _occupation,
              'monthly_income': _incomeLevel,
              'financial_goals': _financialAim,
            };
            print('==============');
            print('Occupation: $dataToSubmit');
            await context.read<AppViewModel>().collectUserPersonalization(dataToSubmit, context);

          }
        )
      ],
    );
  }
}