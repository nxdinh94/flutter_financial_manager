import 'package:fe_financial_manager/view/onboarding/income_level_page.dart';
import 'package:fe_financial_manager/view/onboarding/occupation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();

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
          callback:  () {
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        IncomeLevelPage(
          callback: () {
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        ColoredBox(
          color: Colors.blue,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: const Text('Previous'),
            ),
          ),
        ),
        ColoredBox(
          color: Colors.blue,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Pop'),
            ),
          ),
        ),
      ],
    );
  }
}