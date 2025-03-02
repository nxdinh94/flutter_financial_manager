import 'package:fe_financial_manager/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackNavbar extends StatelessWidget {
  const CustomBackNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: Row(
        children: [
          Padding(
            padding: defaultHalfPadding,
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              size: 20,
            ),
          ),
          // Text('My Account')
        ],
      )
    );
  }
}
