import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:fe_financial_manager/view/common_widget/my_list_title.dart';
import 'package:flutter/material.dart';

class AddingWorkspace extends StatefulWidget {
  const AddingWorkspace({super.key});

  @override
  State<AddingWorkspace> createState() => _AddingWorkspaceState();
}

class _AddingWorkspaceState extends State<AddingWorkspace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            MyListTitle(
              title: 'Tiền mặt',
              callback: () {  },
              leading: Icon(Icons.add),
              titleTextStyle: TextStyle(
                color: colorTextLabel,
                fontSize: 30,
                // fontWeight: FontWeight.w700
              ),
            )
          ],
        ),
      ),
    );
  }
}
