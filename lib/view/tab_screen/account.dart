import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: SvgPicture.asset('assets/svg/abc.svg', ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('More', style: Theme.of(context).textTheme.headlineLarge,),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [

          ],
        ),
      ),
    );

  }
}
