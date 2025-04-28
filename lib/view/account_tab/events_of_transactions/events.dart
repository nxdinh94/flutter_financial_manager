import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/paths.dart';
class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        leading: const CustomBackNavbar(),
        actions: [
          GestureDetector(
              onTap: (){
                context.push(FinalRoutes.createUpdateBudgetPath);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.add, size: 24,),
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}
