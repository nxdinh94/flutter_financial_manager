import 'package:flutter/material.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:go_router/go_router.dart';

class CustomBackNavbar extends StatelessWidget {
  const CustomBackNavbar({super.key, this.value});
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop(value ?? '');
      },
      child: const Row(
        children: [
          Padding(
            padding: defaultHalfPadding,
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              size: 20,
            ),
          ),
        ],
      )
    );
  }
}
