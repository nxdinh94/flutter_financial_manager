import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        leading: CustomBackNavbar(),
        actions: [
          GestureDetector(
            onTap: (){
              context.push('${RoutesName.accountPath}/${RoutesName.createEventPath}');
            },
            child: Icon(Icons.add, size: 44,)
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
