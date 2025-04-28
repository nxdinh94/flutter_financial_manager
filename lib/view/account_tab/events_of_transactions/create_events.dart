import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';

import '../../common_widget/svg_container.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({super.key});

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: const CustomBackNavbar(),
        title: const Text('New Events'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Handle save event
            },
            child: const Text(
              'Lưu',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: SvgContainer(
              iconPath: Assets.svgBell,
              iconWidth: 24,
            ), // Avatar cho Event Name
            title: const Text('Tên'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Ngày'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Việt Nam Đồng'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(height: 1),
          const ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Tiền mặt'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
