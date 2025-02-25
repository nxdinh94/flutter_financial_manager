
import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

class HomeAuth extends StatefulWidget {
  const HomeAuth({super.key});

  @override
  State<HomeAuth> createState() => _HomeAuthState();
}

class _HomeAuthState extends State<HomeAuth> {

  double indicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        // toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: SizedBox(
          width: 180,
          height: 180,
          child: SvgPicture.asset(
            'assets/svg/money-lover-logo.svg',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary
                ),
                child: Text(
                  'English',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                    fontWeight: Theme.of(context).textTheme.titleSmall?.fontWeight,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: horizontalPadding,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: double.infinity,
                      autoPlay: true,
                      viewportFraction: 1,
                      pauseAutoPlayOnTouch: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          indicatorIndex = index.toDouble();
                        });
                      },
                    ),
                    items: [1,2,3,4,5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface
                              ),
                              child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DotsIndicator(
                      dotsCount: 5,
                      position: indicatorIndex,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: (){
                          context.push('${RoutesName.homeAuthPath}/${RoutesName.signUpPath}');
                        },
                        child: const Text(
                          'Sign up for free', style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: (){
                          context.push('${RoutesName.homeAuthPath}/${RoutesName.signInPath}');
                        },
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
                          // other properties
                        ),
                        child: Text('Sign in', style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.w600
                        ),)
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('Version 8.31.1', style: Theme.of(context).textTheme.labelSmall,)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
